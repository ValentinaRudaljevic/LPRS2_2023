
#ifndef UTILS_H
#define UTILS_H


///////////////////////////////////////////////////////////////////////////


#include <iostream>
#include <string>
#include <functional>

using namespace std;

///////////////////////////////////////////////////////////////////////////////

#define DEBUG(var) do{cout << #var << " = " << var << endl; }while(false)
#define DEBUG_HEX(var) do{cout << #var << " = " << hex << var << dec << endl; }while(false)
#define TRACE() do{cout << __PRETTY_FUNCTION__ << ":" << __LINE__ << endl; }while(false)

///////////////////////////////////////////////////////////////////////////


string sprintf2(const char* format, ...);


///////////////////////////////////////////////////////////////////////////

namespace __priv_utils {
	void set_dump_time(const string& time);
	void dump_var(
		const char* var_name,
		const char* fn,
		int ln,
		function<void(ostream&)> wc
	);
};

#define DUMP_TIME1(iter) do{ \
	__priv_utils::set_dump_time(sprintf2("iter%04d", iter)); \
}while(false)

#define DUMP_TIME2(iter, tj, ti) do{ \
	__priv_utils::set_dump_time(sprintf2("iter%04d-tj%02d-ti%02d", iter, tj, ti)); \
}while(false)

#define DUMP_VAR(var) do{ \
	__priv_utils::dump_var( \
		#var, \
		__FILE__, \
		__LINE__, \
		[&](ostream& os){ \
			os.write(reinterpret_cast<const char*>(&var), sizeof(var)); \
		} \
	); \
}while(false)

///////////////////////////////////////////////////////////////////////////

#endif // UTILS_H