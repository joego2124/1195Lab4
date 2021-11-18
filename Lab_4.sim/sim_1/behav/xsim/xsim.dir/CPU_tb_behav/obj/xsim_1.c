/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                         */
/*  \   \        Copyright (c) 2003-2013 Xilinx, Inc.                 */
/*  /   /        All Right Reserved.                                  */
/* /---/   /\                                                         */
/* \   \  /  \                                                        */
/*  \___\/\___\                                                       */
/**********************************************************************/


#include "iki.h"
#include <string.h>
#include <math.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
typedef void (*funcp)(char *, char *);
extern int main(int, char**);
extern void execute_2(char*, char *);
extern void execute_3(char*, char *);
extern void execute_4(char*, char *);
extern void execute_5(char*, char *);
extern void execute_6(char*, char *);
extern void execute_7(char*, char *);
extern void execute_8(char*, char *);
extern void execute_9(char*, char *);
extern void execute_317(char*, char *);
extern void execute_320(char*, char *);
extern void execute_321(char*, char *);
extern void execute_322(char*, char *);
extern void execute_323(char*, char *);
extern void execute_324(char*, char *);
extern void execute_325(char*, char *);
extern void execute_332(char*, char *);
extern void execute_333(char*, char *);
extern void execute_334(char*, char *);
extern void execute_335(char*, char *);
extern void execute_348(char*, char *);
extern void execute_351(char*, char *);
extern void execute_352(char*, char *);
extern void execute_353(char*, char *);
extern void execute_354(char*, char *);
extern void execute_38(char*, char *);
extern void execute_39(char*, char *);
extern void execute_40(char*, char *);
extern void execute_41(char*, char *);
extern void execute_42(char*, char *);
extern void execute_311(char*, char *);
extern void execute_312(char*, char *);
extern void execute_45(char*, char *);
extern void execute_47(char*, char *);
extern void execute_48(char*, char *);
extern void execute_50(char*, char *);
extern void execute_51(char*, char *);
extern void execute_306(char*, char *);
extern void execute_307(char*, char *);
extern void execute_309(char*, char *);
extern void execute_310(char*, char *);
extern void execute_314(char*, char *);
extern void execute_319(char*, char *);
extern void execute_337(char*, char *);
extern void execute_339(char*, char *);
extern void execute_341(char*, char *);
extern void execute_343(char*, char *);
extern void execute_344(char*, char *);
extern void execute_345(char*, char *);
extern void execute_493(char*, char *);
extern void execute_357(char*, char *);
extern void execute_359(char*, char *);
extern void execute_360(char*, char *);
extern void execute_361(char*, char *);
extern void execute_362(char*, char *);
extern void execute_363(char*, char *);
extern void execute_364(char*, char *);
extern void execute_365(char*, char *);
extern void execute_366(char*, char *);
extern void execute_367(char*, char *);
extern void execute_368(char*, char *);
extern void execute_369(char*, char *);
extern void execute_370(char*, char *);
extern void execute_372(char*, char *);
extern void execute_373(char*, char *);
extern void execute_374(char*, char *);
extern void execute_375(char*, char *);
extern void execute_376(char*, char *);
extern void execute_377(char*, char *);
extern void execute_388(char*, char *);
extern void execute_389(char*, char *);
extern void execute_390(char*, char *);
extern void execute_391(char*, char *);
extern void execute_392(char*, char *);
extern void execute_393(char*, char *);
extern void execute_394(char*, char *);
extern void execute_395(char*, char *);
extern void execute_396(char*, char *);
extern void execute_397(char*, char *);
extern void execute_398(char*, char *);
extern void execute_400(char*, char *);
extern void execute_401(char*, char *);
extern void execute_403(char*, char *);
extern void execute_404(char*, char *);
extern void execute_406(char*, char *);
extern void execute_407(char*, char *);
extern void execute_409(char*, char *);
extern void execute_410(char*, char *);
extern void execute_412(char*, char *);
extern void execute_413(char*, char *);
extern void execute_415(char*, char *);
extern void execute_416(char*, char *);
extern void execute_418(char*, char *);
extern void execute_419(char*, char *);
extern void execute_421(char*, char *);
extern void execute_422(char*, char *);
extern void execute_424(char*, char *);
extern void execute_425(char*, char *);
extern void execute_427(char*, char *);
extern void execute_428(char*, char *);
extern void execute_430(char*, char *);
extern void execute_431(char*, char *);
extern void execute_433(char*, char *);
extern void execute_434(char*, char *);
extern void execute_436(char*, char *);
extern void execute_437(char*, char *);
extern void execute_439(char*, char *);
extern void execute_440(char*, char *);
extern void execute_442(char*, char *);
extern void execute_443(char*, char *);
extern void execute_445(char*, char *);
extern void execute_446(char*, char *);
extern void execute_448(char*, char *);
extern void execute_449(char*, char *);
extern void execute_451(char*, char *);
extern void execute_452(char*, char *);
extern void execute_454(char*, char *);
extern void execute_455(char*, char *);
extern void execute_457(char*, char *);
extern void execute_458(char*, char *);
extern void execute_460(char*, char *);
extern void execute_461(char*, char *);
extern void execute_463(char*, char *);
extern void execute_464(char*, char *);
extern void execute_466(char*, char *);
extern void execute_467(char*, char *);
extern void execute_469(char*, char *);
extern void execute_470(char*, char *);
extern void execute_472(char*, char *);
extern void execute_473(char*, char *);
extern void execute_475(char*, char *);
extern void execute_476(char*, char *);
extern void execute_478(char*, char *);
extern void execute_479(char*, char *);
extern void execute_481(char*, char *);
extern void execute_482(char*, char *);
extern void execute_484(char*, char *);
extern void execute_485(char*, char *);
extern void execute_487(char*, char *);
extern void execute_488(char*, char *);
extern void execute_490(char*, char *);
extern void execute_491(char*, char *);
extern void execute_497(char*, char *);
extern void execute_498(char*, char *);
extern void execute_499(char*, char *);
extern void execute_500(char*, char *);
extern void vlog_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void vhdl_transfunc_eventcallback(char*, char*, unsigned, unsigned, unsigned, char *);
extern void transaction_34(char*, char*, unsigned, unsigned, unsigned);
extern void transaction_155(char*, char*, unsigned, unsigned, unsigned);
funcp funcTab[149] = {(funcp)execute_2, (funcp)execute_3, (funcp)execute_4, (funcp)execute_5, (funcp)execute_6, (funcp)execute_7, (funcp)execute_8, (funcp)execute_9, (funcp)execute_317, (funcp)execute_320, (funcp)execute_321, (funcp)execute_322, (funcp)execute_323, (funcp)execute_324, (funcp)execute_325, (funcp)execute_332, (funcp)execute_333, (funcp)execute_334, (funcp)execute_335, (funcp)execute_348, (funcp)execute_351, (funcp)execute_352, (funcp)execute_353, (funcp)execute_354, (funcp)execute_38, (funcp)execute_39, (funcp)execute_40, (funcp)execute_41, (funcp)execute_42, (funcp)execute_311, (funcp)execute_312, (funcp)execute_45, (funcp)execute_47, (funcp)execute_48, (funcp)execute_50, (funcp)execute_51, (funcp)execute_306, (funcp)execute_307, (funcp)execute_309, (funcp)execute_310, (funcp)execute_314, (funcp)execute_319, (funcp)execute_337, (funcp)execute_339, (funcp)execute_341, (funcp)execute_343, (funcp)execute_344, (funcp)execute_345, (funcp)execute_493, (funcp)execute_357, (funcp)execute_359, (funcp)execute_360, (funcp)execute_361, (funcp)execute_362, (funcp)execute_363, (funcp)execute_364, (funcp)execute_365, (funcp)execute_366, (funcp)execute_367, (funcp)execute_368, (funcp)execute_369, (funcp)execute_370, (funcp)execute_372, (funcp)execute_373, (funcp)execute_374, (funcp)execute_375, (funcp)execute_376, (funcp)execute_377, (funcp)execute_388, (funcp)execute_389, (funcp)execute_390, (funcp)execute_391, (funcp)execute_392, (funcp)execute_393, (funcp)execute_394, (funcp)execute_395, (funcp)execute_396, (funcp)execute_397, (funcp)execute_398, (funcp)execute_400, (funcp)execute_401, (funcp)execute_403, (funcp)execute_404, (funcp)execute_406, (funcp)execute_407, (funcp)execute_409, (funcp)execute_410, (funcp)execute_412, (funcp)execute_413, (funcp)execute_415, (funcp)execute_416, (funcp)execute_418, (funcp)execute_419, (funcp)execute_421, (funcp)execute_422, (funcp)execute_424, (funcp)execute_425, (funcp)execute_427, (funcp)execute_428, (funcp)execute_430, (funcp)execute_431, (funcp)execute_433, (funcp)execute_434, (funcp)execute_436, (funcp)execute_437, (funcp)execute_439, (funcp)execute_440, (funcp)execute_442, (funcp)execute_443, (funcp)execute_445, (funcp)execute_446, (funcp)execute_448, (funcp)execute_449, (funcp)execute_451, (funcp)execute_452, (funcp)execute_454, (funcp)execute_455, (funcp)execute_457, (funcp)execute_458, (funcp)execute_460, (funcp)execute_461, (funcp)execute_463, (funcp)execute_464, (funcp)execute_466, (funcp)execute_467, (funcp)execute_469, (funcp)execute_470, (funcp)execute_472, (funcp)execute_473, (funcp)execute_475, (funcp)execute_476, (funcp)execute_478, (funcp)execute_479, (funcp)execute_481, (funcp)execute_482, (funcp)execute_484, (funcp)execute_485, (funcp)execute_487, (funcp)execute_488, (funcp)execute_490, (funcp)execute_491, (funcp)execute_497, (funcp)execute_498, (funcp)execute_499, (funcp)execute_500, (funcp)vlog_transfunc_eventcallback, (funcp)vhdl_transfunc_eventcallback, (funcp)transaction_34, (funcp)transaction_155};
const int NumRelocateId= 149;

void relocate(char *dp)
{
	iki_relocate(dp, "xsim.dir/CPU_tb_behav/xsim.reloc",  (void **)funcTab, 149);
	iki_vhdl_file_variable_register(dp + 48568);
	iki_vhdl_file_variable_register(dp + 48624);


	/*Populate the transaction function pointer field in the whole net structure */
}

void sensitize(char *dp)
{
	iki_sensitize(dp, "xsim.dir/CPU_tb_behav/xsim.reloc");
}

void simulate(char *dp)
{
		iki_schedule_processes_at_time_zero(dp, "xsim.dir/CPU_tb_behav/xsim.reloc");
	// Initialize Verilog nets in mixed simulation, for the cases when the value at time 0 should be propagated from the mixed language Vhdl net
	iki_execute_processes();

	// Schedule resolution functions for the multiply driven Verilog nets that have strength
	// Schedule transaction functions for the singly driven Verilog nets that have strength

}
#include "iki_bridge.h"
void relocate(char *);

void sensitize(char *);

void simulate(char *);

extern SYSTEMCLIB_IMP_DLLSPEC void local_register_implicit_channel(int, char*);
extern void implicit_HDL_SCinstatiate();

extern SYSTEMCLIB_IMP_DLLSPEC int xsim_argc_copy ;
extern SYSTEMCLIB_IMP_DLLSPEC char** xsim_argv_copy ;

int main(int argc, char **argv)
{
    iki_heap_initialize("ms", "isimmm", 0, 2147483648) ;
    iki_set_sv_type_file_path_name("xsim.dir/CPU_tb_behav/xsim.svtype");
    iki_set_crvs_dump_file_path_name("xsim.dir/CPU_tb_behav/xsim.crvsdump");
    void* design_handle = iki_create_design("xsim.dir/CPU_tb_behav/xsim.mem", (void *)relocate, (void *)sensitize, (void *)simulate, 0, isimBridge_getWdbWriter(), 0, argc, argv);
     iki_set_rc_trial_count(100);
    (void) design_handle;
    return iki_simulate_design();
}
