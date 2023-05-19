
#include <stdint.h>
//#include <math.h>

#define BUFFER_SIZE_ADDRESS 0x00003000 
#define BUFFER_START_ADDRESS 0x00003004 
//#define BUFFER_END_ADDRESS 0x00004000 
#define BUFFER_END_ADDRESS 0x00003ffc 
#define SDRAM_START_ADDRESS 0x00400000
#define SDRAM_END_ADDRESS 0x004fffff



#define LEDS_ADDR 0x10000000

#define dvu32p(a) (*(volatile uint32_t*)(a))
#define dvu8p(a) (*(volatile uint8_t*)(a))  
#define wait_false(e) while((e) != 0){}
#define wait_true(e) while((e) == 0){}


#define write_leds(x) do{ dvu8p(LEDS_ADDR) = (x); }while(0)
#define POLL_WAIT 1000000
#define POLL_WAIT_SHORT 100000

///////////////////////////////////////////////////////////////////////////////
// Buffer functions from firmware.c
///////////////////////////////////////////////////////////////////////////////
void init_sdram() {
	for(int i = SDRAM_START_ADDRESS; i <= SDRAM_END_ADDRESS; i++) {
		*(volatile char*)i = 0;
	}
}
  
#if 0

void read_buff(uint32_t* buffer, uint32_t size) {
	while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) == 0) {}		//while buffer is empty wait

	uint32_t actual_size = *(volatile uint32_t*)BUFFER_SIZE_ADDRESS;

//	for(int i = 0; i < actual_size>>2; i++) {
	for(int i = 0; i < size; i++) {
		buffer[i] = *((volatile uint32_t*)BUFFER_START_ADDRESS + i);	
	}

	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 0;
}

void write_buff(uint32_t* buffer, uint32_t size) {

	while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) != 0) {}		//while buffer is not empty wait	

	uint32_t actual_size = *(volatile uint32_t*)BUFFER_SIZE_ADDRESS;	
//	*(volatile char*)0x10000000 = actual_size >> 8;	
//	*(volatile char*)0x10000000 = actual_size >> 4;	
//	for(int i = 0; i < actual_size>>2; i++) {
	for(int i = 0; i < size; i++) {
		uint32_t temp = buffer[i];
		*((volatile uint32_t*)BUFFER_START_ADDRESS + i) = temp;
	}

	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = size * 4;
}

void clear_buff() {
	while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) == 0) {}		//while buffer is empty wait	
	for(int i = BUFFER_START_ADDRESS; i <= BUFFER_END_ADDRESS; i++) {
		*(volatile char*)i = 0;
	}	
	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 0;	
}

#endif

volatile int reads = 0;

void busy_wait(volatile uint32_t poll) {
	for(uint32_t i = 0; i < POLL_WAIT; i++) {
		poll = i;
	} 
}

void clear_buff() {
	for(int i = BUFFER_START_ADDRESS; i <= BUFFER_END_ADDRESS; i++) {
		*(volatile char*)i = 0;
	}	
	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 0;	
}

///////////////////////////////////////////////////////////////////////////////
//	main.cpp classes and functions
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Class Widen
///////////////////////////////////////////////////////////////////////////////

template<typename T>
class widen {
};

template<>
class widen<int16_t> {
public:
	typedef int32_t t;
};

template<>
class widen<int32_t> {
public:
	typedef int64_t t;
};

template<>
class widen<int64_t> {
public:
	typedef int64_t t; // There is no int128_t, but it work with this anyway.
};

///////////////////////////////////////////////////////////////////////////////
// Class idx - Index
///////////////////////////////////////////////////////////////////////////////
class idx {
public:
	int r;
	int c;
	idx(int r_, int c_) : r(r_), c(c_) {}
	idx(int i) : r(i), c(0) {}
};

///////////////////////////////////////////////////////////////////////////////
// Class Fixed - Fixed point
///////////////////////////////////////////////////////////////////////////////
template<typename T, int f>
class Fixed;

template<typename T, int f>
Fixed<T, f> operator+(const Fixed<T, f>& f1, const Fixed<T, f>& f2);

template<typename T, int f>
Fixed<T, f> operator-(const Fixed<T, f>& f1, const Fixed<T, f>& f2);

template<typename T, int f>
Fixed<T, f> operator*(const Fixed<T, f>& f1, const Fixed<T, f>& f2);


template<typename T, int f>
class Fixed {
public:
	T i;								//moze da bude samo int8, int16 i int32
	typedef T rawtype;
	static const int nbitsfrac = f;

	Fixed() : i(0) {}
	Fixed(T data) : i(data) {}

	bool operator==(const Fixed& o) const {
		return i == o.i;
	}

	bool operator<(const Fixed& o) const {
		return i < o.i;
	}

	bool operator>(const Fixed& o) const {
		return i > o.i;
	}

	bool operator<=(const Fixed& o) const {
		return i <= o.i;
	}

	Fixed<T, f> operator-() const {
		Fixed<T, f> temp(*this);
		temp.i = -temp.i;
		return temp;
	}
	Fixed<T, f> operator+() const {
		return *this;
	}

	Fixed<T, f> operator+=(const Fixed<T, f>& f1) {
		this->i += f1.i;
		return *this;
	}

};

template<typename T, int f>
Fixed<T, f> operator+(const Fixed<T, f>& f1, const Fixed<T, f>& f2) {
	Fixed<T, f> temp(f1.i + f2.i);
	return temp;
}

template<typename T, int f>
Fixed<T, f> operator-(const Fixed<T, f>& f1, const Fixed<T, f>& f2) {
	Fixed<T, f> temp(f1.i - f2.i);
	return temp;
}

template<typename T, int f>
Fixed<T, f> operator*(const Fixed<T, f>& f1, const Fixed<T, f>& f2) {
	typedef typename widen<T>::t WT;
	return (WT(f1.i)*WT(f2.i) + (WT(1) << (f - 1))) >> f;
}

template<typename T, int f>
Fixed<T, f> abs(const Fixed<T, f>& x) {
	if (x.i >= 0) {
		return x;
	}
	else {
		Fixed<T, f> temp;
		temp.i = -x.i;
		return temp;
	}
}

///////////////////////////////////////////////////////////////////////////////
// Class Matrix 
///////////////////////////////////////////////////////////////////////////////
template<class T, int rows, int cols>
class Matrix;

template<class T, int rows, int cols>
Matrix<T, rows, cols> operator+(const Matrix<T, rows, cols>& m1, const Matrix<T, rows, cols>& m2);
template<class T, int rows, int cols>
Matrix<T, rows, cols> operator-(const Matrix<T, rows, cols>& m1, const Matrix<T, rows, cols>& m2);
template<class T, int rows1, int cols1rows2, int cols2>
Matrix<T, rows1, cols2> operator*(const Matrix<T, rows1, cols1rows2>& m1, const Matrix<T, cols1rows2, cols2>& m2);

template<class T, int rows, int cols>
class Matrix {
public: // TODO Should be private.
		/*
		Column-major:
		m[idx(r, c)] <=> m.elements[r + c*rows]
		Faster to first advance rows:
		for(int c = 0; c < m.getCols(); c++){
		for(int r = 0; r < m.getRows(); r++){
		m[idx(r, c)]
		}
		}
		*/
	T elements[rows*cols];
public:
	Matrix() {
		for (int i = 0; i < rows*cols; i++) {
			elements[i] = 0;
		}
	}

	int getRows() const { return rows; }
	int getCols() const { return cols; }
	int getSize() const { return rows * cols; }

	T operator[](int i) const { return elements[i]; }
	T& operator[](int i) { return elements[i]; }

	T operator[](idx i) const {
		return elements[i.r + i.c * rows];
	}
	T& operator[](idx i) {
		return elements[i.r + i.c * rows];
	}

	bool operator==(const Matrix &m) const {
		return elements == m.elements;
	}

	bool operator!=(const Matrix &m) const {
		return elements != m.elements;
	}

	void printMatrix() const;
	void printMatrixInfo() const;

	Matrix<T, rows, cols>& operator=(const Matrix<T, rows, cols>&);
	Matrix<T, rows, cols>& operator+=(const Matrix<T, rows, cols>&);
	Matrix<T, rows, cols> dotProduct(Matrix<T, rows, cols>& m1, Matrix<T, rows, cols>& m2);
};


template<class T, int rows, int cols>
Matrix<T, rows, cols>& Matrix<T, rows, cols>::operator=(const Matrix<T, rows, cols>& eq) {
	// TODO add checks that rows and cols > 0
	for (int i = 0; i < eq.getSize(); i++) {
		elements[i] = eq[i];
	}
	return *this;
}

template<class T, int rows, int cols>
Matrix<T, rows, cols>& Matrix<T, rows, cols>::operator+=(const Matrix<T, rows, cols>& eq) {
	// TODO add checks that rows and cols > 0
	for (int i = 0; i < eq.getSize(); i++) {
		elements[i] += eq[i];
	}
	return *this;
}

template<class T, int rows, int cols>
Matrix<T, rows, cols> operator+(const Matrix<T, rows, cols>& m1, const Matrix<T, rows, cols>& m2) {
	// TODO add checks that rows and cols > 0
	Matrix<int, cols, rows> temp;
	for (int i = 0; i < m1.getSize(); i++) {
		temp.elements[i] = m1.elements[i] + m2.elements[i];
	}
	return temp;
}

template<class T, int rows, int cols>
Matrix<T, rows, cols> operator-(const Matrix<T, rows, cols>& m1, const Matrix<T, rows, cols>& m2) {
	// TODO add checks that rows and cols > 0
	Matrix<int, cols, rows> temp;
	for (int i = 0; i < m1.getSize(); i++) {
		temp.elements[i] = m1.elements[i] - m2.elements[i];
	}
	return temp;
}

template<class T, int rows, int cols>
Matrix<T, rows, cols> dotProduct(Matrix<T, rows, cols>& m1, Matrix<T, rows, cols>& m2) {
	// TODO add checks that rows and cols > 0
	Matrix<int, cols, rows> temp;
	for (int i = 0; i < m1.getSize(); i++) {
		temp.elements[i] = m1.elements[i] * m2.elements[i];
	}
	return temp;
}

template<class T, int rows1, int cols1rows2, int cols2>
Matrix<T, rows1, cols2> operator*(const Matrix<T, rows1, cols1rows2>& m1, const Matrix<T, cols1rows2, cols2>& m2) {
	// TODO add checks that rows and cols > 0 and other cheks
	Matrix<int, rows1, cols2> temp;
	for (int i = 0; i < rows1; i++) {
		for (int j = 0; j < cols2; j++) {
			for (int k = 0; k < cols1rows2; k++) {
				temp[idx(idx(i, j))] += m1[idx(idx(i, k))] * m2[idx(idx(k, j))];
			}
		}
	}
	return temp;
}


template<class T, int rows, int cols>
T sum(const Matrix<T, rows, cols>& m) {
	T acc;
	for (int r = 0; r < m.getRows(); r++) {
		for (int c = 0; c < m.getCols(); c++) {
			acc += m[idx(r, c)];
		}
	}
	return acc;
}

///////////////////////////////////////////////////////////////////////////////
// Class RW - Reader Writer 
///////////////////////////////////////////////////////////////////////////////

class RW {
public:
	////////// FPGA //////////
	uint32_t* buf;

	RW() {
		buf = (uint32_t*) BUFFER_START_ADDRESS;
	}

	void set_buf(uint32_t* buf_) {				//FIXME maybe unnecessasry?
		buf = buf_;
	}


	template<typename T>
	void read_buf(T& a) {
		char* buf_temp = (char*) buf;
		char* a_temp = (char*) &a;
		int size = sizeof(a);
		for(int i = 0; i < size; i++) {		
			*a_temp = *buf_temp;
			buf_temp++;
			a_temp++;
		}
		buf += sizeof(a) / 4;			// changed
		//TODO ubaciti proveru za buffer
	}

	template<class T, int rows, int cols>
	void read_buf(Matrix<T, rows, cols>& m) {
		while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) == 0) {} //wait while buffer is empty
		char* buf_temp = (char*) buf;
		char* m_temp = (char*) &m;
		int32_t size = sizeof(m);

		while(size != 0) {				
			if(buf_temp == (char*)BUFFER_END_ADDRESS) {	//if end of buffer is reached
				for(int i = BUFFER_START_ADDRESS; i <= BUFFER_END_ADDRESS; i++) {
					*(volatile char*)i = 0;
				}	
				*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 0;
				while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) == 0) {}
				buf_temp = (char*) BUFFER_START_ADDRESS;//reset the pointer
			} else {
				*m_temp = *buf_temp;				
				buf_temp++;
				m_temp++;
				size--;
			}		
		}		
		buf = (uint32_t*) buf_temp ;
	}


	template<typename T>
	void write_buf(T a) {
		char* buf_temp = (char*) buf;
		char* a_temp = (char*) &a;
		int size = sizeof(a);
		for(int i = 0; i < size; i++) {		
			*buf_temp = *a_temp;
			buf_temp++;
			a_temp++;
		}
		buf += sizeof(a) / 4;
	}

	template<class T, int rows, int cols>
	void write_buf(Matrix<T, rows, cols>& m) {
		while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) != 0) {} // wait while buffer not empty
		char* buf_temp = (char*) buf;
		char* m_temp = (char*) &m;
		int size = sizeof(m);
		//TODO napraviti proveru velicine, ako je veca od bafera, sinhronizacija itd.
/*		for(int i = 0; i < size; i++) {		
			*buf_temp = *m_temp;
			buf_temp++;
			m_temp++;
		}
		buf += sizeof(m);
*/
		while(size != 0) {				
			if(buf_temp == (char*)BUFFER_END_ADDRESS) {	//if end of buffer is reached			
				*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = size; // remaining size to be transferred
				while((*(volatile uint32_t*)BUFFER_SIZE_ADDRESS) != 0) {}
				buf_temp = (char*) BUFFER_START_ADDRESS;//reset the pointer
//				write_leds(++reads);
			} else {
				*buf_temp = *m_temp;				
				buf_temp++;
				m_temp++;
				size--;
			}		
		}		
		buf = (uint32_t*) buf_temp ;
	}
};


///////////////////////////////////////////////////////////////////////////////
//	Class - t_range (used to be pair<int, int>) typedef pair<int, int> t_range;		//dodati sta treba
///////////////////////////////////////////////////////////////////////////////
class t_range {
	public: 
		int first;
		int second;

		t_range(int a, int b) {
			first = a;
			second = b;
		}
};


///////////////////////////////////////////////////////////////////////////////
//	Typedefs
///////////////////////////////////////////////////////////////////////////////

typedef Fixed<int32_t, 26> XT;
typedef Fixed<int16_t, 14> BFT;
typedef int8_t BET;

///////////////////////////////////////////////////////////////////////////////
//	Globals
///////////////////////////////////////////////////////////////////////////////

const int hc_N_xy = 64;
const int hc_T_xy = 8;

const int32_t hc_N_tiles_xy = hc_N_xy / hc_T_xy;			//changed to int32_t

int32_t N_max_iters;
int32_t N_tiles_x;											//changed to int32_t
int32_t N_tiles_y;											//changed to int32_t

Matrix<BET, hc_T_xy, hc_T_xy> mE_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mE_bf;
Matrix<BET, hc_T_xy, hc_T_xy> nEz_be;
Matrix<BFT, hc_N_xy, hc_N_xy> nEz_bf;

int32_t T_x;												//changed to int32_t
int32_t T_y;												//changed to int32_t

Matrix<BET, hc_T_xy, hc_T_xy> I_CE_x_be;
Matrix<BFT, hc_N_xy, hc_N_xy> I_CE_x_bf;
Matrix<BET, hc_T_xy, hc_T_xy> I_CE_y_be;
Matrix<BFT, hc_N_xy, hc_N_xy> I_CE_y_bf;

Matrix<BET, hc_T_xy, hc_T_xy> Hx_be;
Matrix<BFT, hc_N_xy, hc_N_xy> Hx_bf;
Matrix<BET, hc_T_xy, hc_T_xy> Hy_be;
Matrix<BFT, hc_N_xy, hc_N_xy> Hy_bf;

Matrix<BET, hc_T_xy, hc_T_xy> mHx1_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHx1_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mHx3_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHx3_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mHx4_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHx4_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mHy1_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHy1_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mHy3_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHy3_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mHy4_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mHy4_bf;

XT mCE_x; 
XT mCE_y;
XT mI_CE_x;
XT mI_CE_y;

Matrix<BET, hc_T_xy, hc_T_xy> nDz_be;
Matrix<BFT, hc_N_xy, hc_N_xy> nDz_bf;
Matrix<BET, hc_T_xy, hc_T_xy> I_nDz_be;
Matrix<BFT, hc_N_xy, hc_N_xy> I_nDz_bf;

Matrix<BET, hc_T_xy, hc_T_xy> mDz1_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mDz1_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mDz2_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mDz2_bf;
Matrix<BET, hc_T_xy, hc_T_xy> mDz3_be;
Matrix<BFT, hc_N_xy, hc_N_xy> mDz3_bf;

XT mCH_z1;
XT mCH_z2;
XT mI_nDz;

int32_t TS_x;											//changed to int32_t
int32_t TS_y;											//changed to int32_t

Matrix<int32_t, 1, 2> Tx_point;
Matrix<int32_t, 1, 2> Rx_point;

const int hc_N_max_iters = 50;
Matrix<XT, 1, hc_N_max_iters> soft_src_samples;
const int hc_N_Rx = 1;
int32_t N_Rx;											//changed to int32_t
Matrix<int32_t, 2, hc_N_Rx> Rx_points;
int32_t Tx_cycle;										//changed to int32_t
const int hc_N_Tx_cycles = 1;

XT msr_XT[hc_N_max_iters];
Matrix<XT, hc_N_xy, hc_N_xy> log_nEz[hc_N_max_iters];

///////////////////////////////////////////////////////////////////////////
// temporary matrices and values
///////////////////////////////////////////////////////////////////////////
Matrix<XT, hc_T_xy, hc_T_xy> nEz_t;
Matrix<XT, hc_T_xy, hc_T_xy> nEz_ti;		//mislim da treba biti 1, hc_T_xy
Matrix<XT, hc_T_xy, hc_T_xy> nEz_tj;		//isto

Matrix<XT, hc_T_xy, hc_T_xy> I_CE_x_t;
Matrix<XT, hc_T_xy, hc_T_xy> I_CE_y_t;
Matrix<XT, hc_T_xy, hc_T_xy> Hx_t;
Matrix<XT, hc_T_xy, hc_T_xy> Hy_t;

Matrix<XT, hc_T_xy, hc_T_xy> Hx_tj;			//mislim da treba biti 1, hc_T_xy
Matrix<XT, hc_T_xy, hc_T_xy> Hy_ti;			//isto

Matrix<XT, hc_T_xy, hc_T_xy> mHx1_t;
Matrix<XT, hc_T_xy, hc_T_xy> mHx3_t;
Matrix<XT, hc_T_xy, hc_T_xy> mHx4_t;
Matrix<XT, hc_T_xy, hc_T_xy> mHy1_t;
Matrix<XT, hc_T_xy, hc_T_xy> mHy3_t;
Matrix<XT, hc_T_xy, hc_T_xy> mHy4_t;

XT CE_x_tmp;
XT CE_y_tmp;

Matrix<XT, hc_T_xy, hc_T_xy> nDz_t;
Matrix<XT, hc_T_xy, hc_T_xy> I_nDz_t;

Matrix<XT, hc_T_xy, hc_T_xy> mDz1_t;
Matrix<XT, hc_T_xy, hc_T_xy> mDz2_t;
Matrix<XT, hc_T_xy, hc_T_xy> mDz3_t;
Matrix<XT, hc_T_xy, hc_T_xy> mE_t;

XT d_Hy;
XT d_Hx;
XT CH_z_tmp;

///////////////////////////////////////////////////////////////////////////
// other functions
///////////////////////////////////////////////////////////////////////////

BET calc_block_exponent(XT max_val) {
	if (max_val == XT(0)) {
		return BET(0);
	}
	XT::rawtype x = max_val.i;
	int N = sizeof(x) * 8;
	XT::rawtype mask = XT::rawtype(1) << (N - 1);
	int bi = 0;
	for (int i = N - 1; i >= 0; i--) {
		if ((x & mask) != 0) {
			bi = i;
			break;
		}
		x <<= 1;
	}
	int b = bi - XT::nbitsfrac + 1;
	return BET(b);
}

BET calc_block_exponent(const Matrix<XT, hc_T_xy, hc_T_xy>& m) {
	//do abs of all elements
	Matrix<XT, hc_T_xy, hc_T_xy> temp_mat;
	XT max_val = abs(m[idx(idx(0, 0))]);
	for (int i = 0; i < hc_T_xy; i++) {
		for (int j = 0; j < hc_T_xy; j++) {
			temp_mat[idx(idx(i, j))] = abs(m[idx(idx(i, j))]);
			if (max_val < temp_mat[idx(idx(i, j))]) {
				max_val = temp_mat[idx(idx(i, j))];
			}
		}
	}
	//find the maximum element
	return calc_block_exponent(max_val);
}

BFT to_block(XT x, BET blk_exp) {							//nesto ne valja
	int sh = blk_exp + XT::nbitsfrac - BFT::nbitsfrac;
	XT::rawtype sh_i;
	if(sh >= 0){
		sh_i = x.i >> sh;
	}else{
		sh_i = x.i << -sh;
	}
	auto bft_i = BFT::rawtype(sh_i);
	return BFT(bft_i);
}

XT from_block(BFT bf, BET blk_exp) {
	int sh = blk_exp + XT::nbitsfrac - BFT::nbitsfrac;
	XT::rawtype i = XT::rawtype(bf.i);
	XT::rawtype sh_i;
	if(sh >= 0){
		sh_i = i << sh;
	}else{
		sh_i = i >> -sh;
	}
	return XT(sh_i);
}

Matrix<XT, hc_T_xy, hc_T_xy> unpack(
	int ti, 		//index
	int tj, 		//index
	const Matrix<BET, hc_T_xy, hc_T_xy>& X_be,
	const Matrix<BFT, hc_N_xy, hc_N_xy>& X_bf,
	t_range ii_range = t_range(0, hc_T_xy),
	t_range jj_range = t_range(0, hc_T_xy),
	bool just_zeros = false
) {

	Matrix<XT, hc_T_xy, hc_T_xy> X_t;
	if (!just_zeros) {
		BET be = X_be[idx(ti, tj)];
		for (int jj = jj_range.first; jj < jj_range.second; jj++) {
			for (int ii = ii_range.first; ii < ii_range.second; ii++) {
				int j = (tj << TS_x) + jj;
				int i = (ti << TS_y) + ii;
				X_t[idx(ii, jj)] = from_block(X_bf[idx(i, j)], be);
			}
		}
	}
	return X_t;
} 

void pack(
	int ti, 		//index
	int tj, 		//index
	const Matrix<XT, hc_T_xy, hc_T_xy>& X_t,
	Matrix<BET, hc_T_xy, hc_T_xy>& X_be,
	Matrix<BFT, hc_N_xy, hc_N_xy>& X_bf
) {
	BET be;
	X_be[idx(ti, tj)] = be = calc_block_exponent(X_t);
	for (int jj = 0; jj < T_y; jj++) {
		for (int ii = 0; ii < T_x; ii++) {
			int j = (tj << TS_x) + jj;
			int i = (ti << TS_y) + ii;
			X_bf[idx(i, j)] = to_block(X_t[idx(ii, jj)], be);			//TODO nadji preostale indekse
		}
	}
} 


/////////////////////////////////////////
// MAIN APP
/////////////////////////////////////////


#if 0

uint32_t a[1024];
uint32_t b[1024];
uint32_t c[1024]; 

int main() {

	write_leds(0xC3);			// (*(volatile uint8_t*)0x10000000 = 0xC3

	init_sdram();

	uint32_t transfer_chunk = 1024;
//	uint32_t transfer_chunk = 10;

	// 1st round

	read_buff(a, transfer_chunk);

	for(uint32_t i = 0; i < transfer_chunk; i++) {
		a[i]+= i;
	} 
 
	write_buff(a, transfer_chunk); 	

	volatile uint32_t poll = 0;
/*	for(uint32_t i = 0; i < POLL_WAIT; i++) {
		poll = i;
	} */
	busy_wait(poll);

	write_leds(0x81);

	// 2nd round

	read_buff(b, transfer_chunk);

/*	for(uint32_t i = 0; i < POLL_WAIT; i++) {
		poll = i;
	} */
	busy_wait(poll);

	for(uint32_t i = 0; i < transfer_chunk; i++) {
		b[i]+= i;
	} 

	write_buff(b, transfer_chunk); 

/*	for(uint32_t i = 0; i < POLL_WAIT; i++) {
		poll = i;
	} */
	busy_wait(poll);

	write_leds(0x83);

	// 3rd round	


	read_buff(c, transfer_chunk);

/*	for(uint32_t i = 0; i < POLL_WAIT; i++) {
		poll = i;
	} */

	for(uint32_t i = 0; i < transfer_chunk; i++) {
		c[i]+= i;
	} 

	write_buff(c, transfer_chunk); 

	write_leds(0x87);

	return 0;

} 

#endif

#if 0

uint32_t a[1024];

int main() {

	uint32_t iter = 0;
	write_leds(iter);

	init_sdram();
	
	uint32_t transfer_chunk = 1024;
//	uint32_t transfer_chunk = 10;
	volatile uint32_t poll = 0;

	while(iter != 38) {

		read_buff(a, transfer_chunk);
		for(uint32_t i = 0; i < transfer_chunk; i++) {
			//a[i]+= i;
			a[i]+= 5;
		} 

		busy_wait(poll);
		write_buff(a, transfer_chunk);
		busy_wait(poll);
 
		iter++;
		write_leds(iter);
	}

	return 0;
} 

#endif

#if 1			// Latest test

//uint32_t a[1024];

int main() {

	write_leds(0x01);
/*
	XT mCE_x;
	XT mCE_y;
	XT mI_CE_x;
	XT mI_CE_y;

	XT CE_x_tmp;
	XT CE_y_tmp;

	mCE_x = 0x0cd74972; 
//	XT baba = 0xbabadeda;
//	XT deda =  baba * (nEz_t[idx(0, 1)] - nEz_t[idx(0, 0)]);
	CE_x_tmp = mCE_x * (nEz_t[idx(0, 1)] - nEz_t[idx(0, 0)]);
*/

//	write_leds(0x02);
//	init_sdram();

	RW rw;

	write_leds(0x02);
	rw.read_buf(N_max_iters);	
	N_max_iters = 50;
	rw.read_buf(N_tiles_x);		
	N_tiles_x = 8;
	rw.read_buf(N_tiles_y);		
	N_tiles_y = 8;
	rw.read_buf(mE_be);			
	rw.read_buf(mE_bf);
	rw.read_buf(nEz_be);
	rw.read_buf(nEz_bf);
	rw.read_buf(T_x);
	rw.read_buf(T_y);						
	rw.read_buf(I_CE_x_be);
	rw.read_buf(I_CE_x_bf);
	rw.read_buf(I_CE_y_be);
	rw.read_buf(I_CE_y_bf);
	rw.read_buf(Hx_be);
	rw.read_buf(Hx_bf);
	rw.read_buf(Hy_be);
	rw.read_buf(Hy_bf);
	rw.read_buf(mHx1_be);
	rw.read_buf(mHx1_bf);
	rw.read_buf(mHx3_be);
	rw.read_buf(mHx3_bf);
	rw.read_buf(mHx4_be);
	rw.read_buf(mHx4_bf);
	rw.read_buf(mHy1_be);
	rw.read_buf(mHy1_bf);
	rw.read_buf(mHy3_be);
	rw.read_buf(mHy3_bf);
	rw.read_buf(mHy4_be);
	rw.read_buf(mHy4_bf);
	rw.read_buf(mCE_x);
	rw.read_buf(mCE_y);
	rw.read_buf(mI_CE_x);
	rw.read_buf(mI_CE_y);	
	rw.read_buf(nDz_be);
	rw.read_buf(nDz_bf);
	rw.read_buf(I_nDz_be);
	rw.read_buf(I_nDz_bf);
	rw.read_buf(mDz1_be);
	rw.read_buf(mDz1_bf);
	rw.read_buf(mDz2_be);
	rw.read_buf(mDz2_bf);	
	rw.read_buf(mDz3_be);
	rw.read_buf(mDz3_bf);		
	rw.read_buf(mCH_z1);
	rw.read_buf(mCH_z2);
	rw.read_buf(mI_nDz);
	rw.read_buf(TS_x);					
	rw.read_buf(TS_y);						
	rw.read_buf(Tx_point);
	rw.read_buf(soft_src_samples);
	rw.read_buf(N_Rx);			
	rw.read_buf(Rx_points);
	rw.read_buf(Tx_cycle);
	
	clear_buff();
	write_leds(0x03);	

#if 0
	rw.buf = (uint32_t*) BUFFER_START_ADDRESS;
	rw.write_buf(N_max_iters);	
	rw.write_buf(N_tiles_x);		
	rw.write_buf(N_tiles_y);		
	rw.write_buf(mE_be);			
	rw.write_buf(mE_bf);
	rw.write_buf(nEz_be);
	rw.write_buf(nEz_bf);
	rw.write_buf(T_x);
	rw.write_buf(T_y);
	rw.write_buf(I_CE_x_be);
	rw.write_buf(I_CE_x_bf);
	rw.write_buf(I_CE_y_be);
	rw.write_buf(I_CE_y_bf);
	rw.write_buf(Hx_be);
	rw.write_buf(Hx_bf);
	rw.write_buf(Hy_be);
	rw.write_buf(Hy_bf);
	rw.write_buf(mHx1_be);
	rw.write_buf(mHx1_bf);
	rw.write_buf(mHx3_be);
	rw.write_buf(mHx3_bf);
	rw.write_buf(mHx4_be);
	rw.write_buf(mHx4_bf);
	rw.write_buf(mHy1_be);
	rw.write_buf(mHy1_bf);
	rw.write_buf(mHy3_be);
	rw.write_buf(mHy3_bf);
	rw.write_buf(mHy4_be);
	rw.write_buf(mHy4_bf);
	rw.write_buf(mCE_x);
	rw.write_buf(mCE_y);
	rw.write_buf(mI_CE_x);
	rw.write_buf(mI_CE_y);	
	rw.write_buf(nDz_be);
	rw.write_buf(nDz_bf);
	rw.write_buf(I_nDz_be);
	rw.write_buf(I_nDz_bf);
	rw.write_buf(mDz1_be);
	rw.write_buf(mDz1_bf);
	rw.write_buf(mDz2_be);
	rw.write_buf(mDz2_bf);
	rw.write_buf(mDz3_be);
	rw.write_buf(mDz3_bf);		
	rw.write_buf(mCH_z1);
	rw.write_buf(mCH_z2);
	rw.write_buf(mI_nDz);
	rw.write_buf(TS_x);			
	rw.write_buf(TS_y);					
	rw.write_buf(Tx_point);
	rw.write_buf(soft_src_samples);
	rw.write_buf(N_Rx);			
	rw.write_buf(Rx_points);
	rw.write_buf(Tx_cycle);

	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 1640; //FIXME
	//perhaps write_buf should always state its size

	write_leds(0x07);	
#endif
	//TODO check with the PC if all the data was read correct and then proceed
	// otherwise, read all the values again and write them

#if 1		
//////////////////////////////////////////////////////////////////////////////
// FDTD
//////////////////////////////////////////////////////////////////////////////

	t_range one_one = t_range(0, 1);
	t_range one_T_y = t_range(0, T_y);
	t_range one_T_x = t_range(0, T_x);
	t_range T_y_minus_one = t_range(T_y - 1, T_y);
	t_range T_x_minus_one = t_range(T_x - 1, T_x);
	//run_loop
	for (int iter = 0; iter < N_max_iters; iter++) {
		write_leds(iter);
		//1st pass
		for (int tj = 0; tj < N_tiles_y; tj++) {
			for (int ti = 0; ti < N_tiles_x; ti++) {
				//unpacking
				nEz_t = unpack(ti, tj, nEz_be, nEz_bf);
				nEz_ti = unpack(ti + 1, tj, nEz_be, nEz_bf, one_one, one_T_y, ti == N_tiles_x-1);				
				nEz_tj = unpack(ti, tj + 1, nEz_be, nEz_bf, one_T_x, one_one, tj == N_tiles_y-1);
				I_CE_x_t = unpack(ti, tj, I_CE_x_be, I_CE_x_bf);
				I_CE_y_t = unpack(ti, tj, I_CE_y_be, I_CE_y_bf);
				Hx_t = unpack(ti, tj, Hx_be, Hx_bf);
				Hy_t = unpack(ti, tj, Hy_be, Hy_bf);
				mHx1_t = unpack(ti, tj, mHx1_be, mHx1_bf);
				mHx3_t = unpack(ti, tj, mHx3_be, mHx3_bf);
				mHx4_t = unpack(ti, tj, mHx4_be, mHx4_bf);
				mHy1_t = unpack(ti, tj, mHy1_be, mHy1_bf);
				mHy3_t = unpack(ti, tj, mHy3_be, mHy3_bf);
				mHy4_t = unpack(ti, tj, mHy4_be, mHy4_bf);

				//calculations
				for (int jj = 0; jj < T_y; jj++) {
					for (int ii = 0; ii < T_x; ii++) {				
						//step 2
						if (jj != T_y-1) {
							CE_x_tmp = mCE_x * (nEz_t[idx(ii, jj + 1)] - nEz_t[idx(ii, jj)]);
//							write_leds(0x0F);		// doesn't work
						}																		
						else {																
							CE_x_tmp = mCE_x * (nEz_tj[idx(ii, 0)] - nEz_t[idx(ii, jj)]);
//							write_leds(0x8F);		// doesn't work
						}

						if (ii != T_x-1) {
							CE_y_tmp = mCE_y * (nEz_t[idx(ii + 1, jj)] - nEz_t[idx(ii, jj)]);
//							write_leds(0x0E);
						}
						else {
							CE_y_tmp = mCE_y * (nEz_ti[idx(0, jj)] - nEz_t[idx(ii, jj)]);
//							write_leds(0x8E);		// doesn't work
						}
						
						//step 3
						I_CE_x_t[idx(ii, jj)] += mI_CE_x * CE_x_tmp;
//						write_leds(0xC0);  //works
						I_CE_y_t[idx(ii, jj)] += mI_CE_y * CE_y_tmp;
//						write_leds(0xC0);						

						//step 4
						Hx_t[idx(ii, jj)] = mHx1_t[idx(ii, jj)] * Hx_t[idx(ii, jj)] + mHx3_t[idx(ii, jj)] * CE_x_tmp + mHx4_t[idx(ii, jj)] * I_CE_x_t[idx(ii, jj)];
						Hy_t[idx(ii, jj)] = mHy1_t[idx(ii, jj)] * Hy_t[idx(ii, jj)] + mHy3_t[idx(ii, jj)] * CE_y_tmp + mHy4_t[idx(ii, jj)] * I_CE_y_t[idx(ii, jj)];
					}
				}
				//packing
				pack(ti, tj, Hx_t, Hx_be, Hx_bf);
				pack(ti, tj, Hy_t, Hy_be, Hy_bf);
				pack(ti, tj, I_CE_x_t, I_CE_x_be, I_CE_x_bf);
				pack(ti, tj, I_CE_y_t, I_CE_y_be, I_CE_y_bf);
//				write_leds(0xC1);		//got to here once!
			}
		}

//write_leds(0x81);			// breaks before here

//		write_leds(0xC2);
#if 1
		//2nd pass
		for (int tj = 0; tj < N_tiles_y; tj++) {
			for (int ti = 0; ti < N_tiles_x; ti++) {
				Hx_t = unpack(ti, tj, Hx_be, Hx_bf);
				Hy_t = unpack(ti, tj, Hy_be, Hy_bf);
				Hx_tj = unpack(ti, tj - 1, Hx_be, Hx_bf, one_T_x, T_y_minus_one, tj == 0);
				Hy_ti = unpack(ti - 1, tj, Hy_be, Hy_bf, T_x_minus_one, one_T_y, ti == 0);
				nDz_t = unpack(ti, tj, nDz_be, nDz_bf);	
				I_nDz_t = unpack(ti, tj, I_nDz_be, I_nDz_bf);
				mDz1_t = unpack(ti, tj, mDz1_be, mDz1_bf);
				mDz2_t = unpack(ti, tj, mDz2_be, mDz2_bf);
				mDz3_t = unpack(ti, tj, mDz3_be, mDz3_bf);
				mE_t = unpack(ti, tj, mE_be, mE_bf);

				//calculations
				for (int jj = 0; jj < T_y; jj++) {
					for (int ii = 0; ii < T_x; ii++) {
						//step 5
						if (ii != 0) {
							d_Hy = Hy_t[idx(ii, jj)] - Hy_t[idx(ii - 1, jj)];
						}
						else {
							d_Hy = Hy_t[idx(ii, jj)] - Hy_ti[idx(T_x-1, jj)];
						}

						if (jj != 0) {
							d_Hx = Hx_t[idx(ii, jj)] - Hx_t[idx(ii, jj - 1)];
						}
						else {
							d_Hx = Hx_t[idx(ii,jj)] - Hx_tj[idx(ii, T_y-1)];
						}
						
						CH_z_tmp = mCH_z1*d_Hy - mCH_z2*d_Hx;
						//step 6
						I_nDz_t[idx(ii, jj)] += mI_nDz*nDz_t[idx(ii, jj)];
						//step 7
						nDz_t[idx(ii, jj)] = mDz1_t[idx(ii, jj)] * nDz_t[idx(ii, jj)] + mDz2_t[idx(ii, jj)] * I_nDz_t[idx(ii, jj)] + mDz3_t[idx(ii, jj)] * CH_z_tmp;
						
						int j = (tj << TS_x) + jj;
						int i = (ti << TS_y) + ii;

						//step 8
						//soft point source
						if (i == Tx_point[0]-1 && j == Tx_point[1]-1) {
							nDz_t[idx(ii, jj)] += soft_src_samples[iter];
						}
						
		//				cout << "***** " << nDz_t[idx(ii, jj)] << "***** " << endl;

						//measurement
						for (int Rx = 0; Rx < N_Rx; Rx++) {
							Rx_point[0] 
								= Rx_points[idx(idx(0, Rx))];
							Rx_point[1] 
								= Rx_points[idx(idx(1, Rx))];
							if (!((Rx_point[0] == Tx_point[0]) && (Rx_point[1] == Tx_point[1]))) {
								if (i+1 == Rx_point[0] && j+1 == Rx_point[1]) {
									msr_XT[iter] 					//haknuto, mora u 2 rade zbog greedy idx
										= nDz_t[idx(ii, jj)];
								}
							}
						}
						//step 9
						nEz_t[idx(ii, jj)] = mE_t[idx(ii, jj)] * nDz_t[idx(ii, jj)];
					}
				}
				
				// Packing.
				pack(ti, tj, nDz_t, nDz_be, nDz_bf);
				pack(ti, tj, I_nDz_t, I_nDz_be, I_nDz_bf);
				pack(ti, tj, nEz_t, nEz_be, nEz_bf);
			}
		}

		Matrix<XT, hc_N_xy, hc_N_xy>& nEz = log_nEz[iter];
		
		for (int tj = 0; tj < N_tiles_y; tj++) {
			for (int ti = 0; ti < N_tiles_x; ti++) {
				nEz_t = unpack(ti, tj, nEz_be, nEz_bf);

				//nEz[idx(i+1:i+T_x,j+1:j+T_y)] = nEz_t
				for(int jj = 0; jj < hc_T_xy; jj++) {
					for(int ii = 0; ii < hc_T_xy; ii++) {
						int j = (tj << TS_x) + jj;
						int i = (ti << TS_y) + ii;
						nEz[idx(i, j)] = nEz_t[idx(ii,jj)];
					}
				}
			}
		}

#endif
	}

#endif
	write_leds(0x80);

	rw.buf = (uint32_t*) BUFFER_START_ADDRESS;

	for(int i = 0; i < hc_N_max_iters; i++) {
		rw.write_buf(msr_XT[i]);		
	}
	*(volatile uint32_t*)BUFFER_SIZE_ADDRESS = 200;
	write_leds(0x81);

	return 0;
} 


#endif
 
//	
//	write_leds(reads);


//#endif

#if 0				// Debugz

int main() {

//	write_leds(0x81);
	init_sdram();

	RW rw;

	rw.read_buf(N_max_iters);	//OK
//	write_leds(N_max_iters);
	rw.read_buf(N_tiles_x);		//OK
	int baba = N_tiles_x;
	write_leds(baba);
	rw.read_buf(N_tiles_y);		//OK
//	write_leds(N_tiles_y+1);
	rw.read_buf(mE_be);			//OK
	rw.read_buf(mE_bf);

	rw.read_buf(nEz_be);
//	write_leds(nEz_be[0]);
	rw.read_buf(nEz_bf);
//	write_leds(nEz_bf[0].nbitsfrac);
//	write_leds(nEz_bf[0].i >> 8);
//	write_leds(nEz_bf[1].nbitsfrac);
//	write_leds(nEz_bf[1].i >> 8);
//	write_leds(nEz_bf[4095].nbitsfrac);
//	write_leds(nEz_bf[4095].i >> 8);
//	write_leds(nEz_bf[0].nbitsfrac);
//	write_leds(nEz_bf[0].i);
//	write_leds(nEz_bf[10000].nbitsfrac);  //makes no sence
//	write_leds(++reads);		//3


	rw.read_buf(T_x);
					// 8 

	rw.read_buf(T_y);						// 8 

//	write_leds(N_max_iters);	

//	write_leds(0x01);
	clear_buff();
//	write_leds(0x03);

//	write_leds(N_max_iters);

	rw.buf = (uint32_t*) BUFFER_START_ADDRESS;

//	write_leds(N_max_iters);

	rw.write_buf(N_max_iters);	
//	write_leds(N_max_iters);
	rw.write_buf(N_tiles_x);		
//	write_leds(N_tiles_x);
	rw.write_buf(N_tiles_y);		
//	write_leds(N_tiles_y);
	rw.write_buf(mE_be);			
//	write_leds(mE_be[0]);
	rw.write_buf(mE_bf);
//	write_leds(mE_bf[0].i >> 8);
	rw.write_buf(nEz_be);
	rw.write_buf(nEz_bf);
	rw.write_buf(T_x);
//	write_leds(T_x);
	rw.write_buf(T_y);
//	write_leds(T_y);



	return 0;
} 



#endif

