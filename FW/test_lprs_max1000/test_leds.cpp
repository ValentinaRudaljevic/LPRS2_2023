
#include <stdint.h>
//#include <math.h>

#define BUFFER_START_ADDRESS 0x00002004 
#define BUFFER_SIZE_ADDRESS 0x00002000 
#define SDRAM_START_ADDRESS 0x00400000
#define SDRAM_END_ADDRESS 0x004fffff

#define LEDS_ADDR 0x10000000

#define dvu32p(a) (*(volatile uint32_t*)(a))
#define dvu8p(a) (*(volatile uint8_t*)(a))  
#define wait_false(e) while((e) != 0){}
#define wait_true(e) while((e) == 0){}


#define write_leds(x) do{ dvu8p(LEDS_ADDR) = (x); }while(0)

void init_sdram() {
	for(int i = SDRAM_START_ADDRESS; i <= SDRAM_END_ADDRESS; i++) {
		*(volatile char*)i = 0;
	}
}

int main() {
	write_leds(0x21);
	
	while(true){}

	return 0;
} 
