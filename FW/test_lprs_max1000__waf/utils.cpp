

///////////////////////////////////////////////////////////////////////////

#include "utils.hpp"


#include <stdarg.h>
#include <stdexcept>
#include <map>
#include <fstream>
using namespace std;


///////////////////////////////////////////////////////////////////////////

string sprintf2(const char* format, ...) {
	va_list args;
	va_start(args, format);
	int n = 256;
	char* buf;
	do{
		buf = new char[n];
		int nr = vsnprintf(buf, n, format, args);
		if(nr < 0){
			throw runtime_error("vsnprintf() error in sprintf2()!");
		}else if(nr < n){
			break;
		}else{
			// Make buf larger.
			delete[] buf;
			n <<= 1;
		}
	}while(true);
	va_end(args);
	
	string r(buf);
	delete[] buf;
	
	return r;
}

///////////////////////////////////////////////////////////////////////////

static map<string, map<string, int>> __dump_pos;
static string __dump_time;

namespace __priv_utils {
	void set_dump_time(const string& time) {
		__dump_time = time;
	}

	void dump_var(
		const char* var_name,
		const char* fn,
		int ln,
		function<void(ostream&)> wc
	) {
		if(__dump_pos.find(var_name) == __dump_pos.end()){
			__dump_pos[var_name] = map<string, int>();
		}
		auto& pos_for_var = __dump_pos[var_name];
		auto pos_key = sprintf2("%s:%d", fn, ln);
		if(pos_for_var.find(pos_key) == pos_for_var.end()){
			pos_for_var[pos_key] = pos_for_var.size();
		}
		auto pos = pos_for_var[pos_key];
		auto dump_fn = sprintf2(
			"%s-pos%02d-%s.bin",
			__dump_time.c_str(),
			pos,
			var_name
		);
		ofstream os;
		os.open(dump_fn, ios::binary);
		wc(os);
		os.close();
	}

};


///////////////////////////////////////////////////////////////////////////
