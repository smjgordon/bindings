/**
 * dswisseph: D port of AstroDienst Swiss Ephemeris library.
 *
 * AstroDienst website http://www.astro.com/swisseph
 *
 * Authors: Stanislas Marquis <stnsls@gmail.com>
 * Swisseph version: 1.72.00
 * Date: 05.04.2008
 *
 */

module swisseph;

extern (C):

const int SE_JUL_CAL = 0;
const int SE_GREG_CAL = 1;

const int SE_ECL_NUT = -1;

const int SE_SUN = 0;
const int SE_MOON = 1;
const int SE_MERCURY = 2;
const int SE_VENUS = 3;
const int SE_MARS = 4;
const int SE_JUPITER = 5;
const int SE_SATURN = 6;
const int SE_URANUS = 7;
const int SE_NEPTUNE = 8;
const int SE_PLUTO = 9;
const int SE_MEAN_NODE = 10;
const int SE_TRUE_NODE = 11;
const int SE_MEAN_APOG = 12;
const int SE_OSCU_APOG = 13;
const int SE_EARTH = 14;
const int SE_CHIRON = 15;
const int SE_PHOLUS = 16;
const int SE_CERES = 17;
const int SE_PALLAS = 18;
const int SE_JUNO = 19;
const int SE_VESTA = 20;
const int SE_INTP_APOG = 21;
const int SE_INTP_PERG = 22;

const int SE_NPLANETS = 23;

const int SE_AST_OFFSET = 10000;
const int SE_VARUNA = SE_AST_OFFSET + 20000;

const int SE_FICT_OFFSET = 40;
const int SE_FICT_OFFSET_1 = 39;
const int SE_FICT_MAX = 999;
const int SE_NFICT_ELEM = 15;

const int SE_COMET_OFFSET = 1000;

const int SE_NALL_NAT_POINTS = SE_NPLANETS + SE_NFICT_ELEM;

const int SE_CUPIDO = 40;
const int SE_HADES = 41;
const int SE_ZEUS = 42;
const int SE_KRONOS = 43;
const int SE_APOLLON = 44;
const int SE_ADMETOS = 45;
const int SE_VULKANUS = 46;
const int SE_POSEIDON = 47;

const int SE_ISIS = 48;
const int SE_NIBIRU = 49;
const int SE_HARRINGTON = 50;
const int SE_NEPTUNE_LEVERRIER = 51;
const int SE_NEPTUNE_ADAMS = 52;
const int SE_PLUTO_LOWELL = 53;
const int SE_PLUTO_PICKERING = 54;
const int SE_VULCAN = 55;
const int SE_WHITE_MOON = 56;
const int SE_PROSERPINA = 57;
const int SE_WALDEMATH = 58;

const int SE_FIXSTAR = -10;

const int SE_ASC = 0;
const int SE_MC = 1;
const int SE_ARMC = 2;
const int SE_VERTEX = 3;
const int SE_EQUASC = 4;
const int SE_COASC1 = 5;
const int SE_COASC2 = 6;
const int SE_POLASC = 7;
const int SE_NASCMC = 8;

const int SEFLG_JPLEPH = 1;
const int SEFLG_SWIEPH = 2;
const int SEFLG_MOSEPH = 4;

const int SEFLG_HELCTR = 8;
const int SEFLG_TRUEPOS = 16;
const int SEFLG_J2000 = 32;
const int SEFLG_NONUT = 64;
const int SEFLG_SPEED3 = 128;
const int SEFLG_SPEED = 256;
const int SEFLG_NOGDEFL = 512;
const int SEFLG_NOABERR = 1024;
const int SEFLG_EQUATORIAL = 2*1024;
const int SEFLG_XYZ = 4*1024;
const int SEFLG_RADIANS = 8*1024;
const int SEFLG_BARYCTR = 16*1024;
const int SEFLG_TOPOCTR = 32*1024;
const int SEFLG_SIDEREAL = 64*1024;
const int SEFLG_ICRS = 128*1024;

const int SE_SIDBITS = 256;

const int SE_SIDBIT_ECL_T0 = 256;

const int SE_SIDBIT_SSY_PLANE = 512;

const int SE_SIDM_FAGAN_BRADLEY = 0;
const int SE_SIDM_LAHIRI = 1;
const int SE_SIDM_DELUCE = 2;
const int SE_SIDM_RAMAN = 3;
const int SE_SIDM_USHASHASHI = 4;
const int SE_SIDM_KRISHNAMURTI = 5;
const int SE_SIDM_DJWHAL_KHUL = 6;
const int SE_SIDM_YUKTESHWAR = 7;
const int SE_SIDM_JN_BHASIN = 8;
const int SE_SIDM_BABYL_KUGLER1 = 9;
const int SE_SIDM_BABYL_KUGLER2 = 10;
const int SE_SIDM_BABYL_KUGLER3 = 11;
const int SE_SIDM_BABYL_HUBER = 12;
const int SE_SIDM_BABYL_ETPSC = 13;
const int SE_SIDM_ALDEBARAN_15TAU = 14;
const int SE_SIDM_HIPPARCHOS = 15;
const int SE_SIDM_SASSANIAN = 16;
const int SE_SIDM_GALCENT_0SAG = 17;
const int SE_SIDM_J2000 = 18;
const int SE_SIDM_J1900 = 19;
const int SE_SIDM_B1950 = 20;
const int SE_SIDM_USER = 255;

const int SE_NSIDM_PREDEF = 21;

const int SE_NODBIT_MEAN = 1;
const int SE_NODBIT_OSCU = 2;
const int SE_NODBIT_OSCU_BAR = 4;
const int SE_NODBIT_FOPOINT = 256;

const int SEFLG_DEFAULTEPH = SEFLG_SWIEPH;

const int SE_MAX_STNAME = 20;

const int SE_ECL_CENTRAL = 1;
const int SE_ECL_NONCENTRAL = 2;
const int SE_ECL_TOTAL = 4;
const int SE_ECL_ANNULAR = 8;
const int SE_ECL_PARTIAL = 16;
const int SE_ECL_ANNULAR_TOTAL = 32;
const int SE_ECL_PENUMBRAL = 64;
const int SE_ECL_VISIBLE = 128;
const int SE_ECL_MAX_VISIBLE = 256;
const int SE_ECL_1ST_VISIBLE = 512;
const int SE_ECL_2ND_VISIBLE = 1024;
const int SE_ECL_3RD_VISIBLE = 2048;
const int SE_ECL_4TH_VISIBLE = 4096;
const int SE_ECL_ONE_TRY = 32*1024;

const int SE_CALC_RISE = 1;
const int SE_CALC_SET = 2;
const int SE_CALC_MTRANSIT = 4;
const int SE_CALC_ITRANSIT = 8;
const int SE_BIT_DISC_CENTER = 256;
const int SE_BIT_NO_REFRACTION = 512;
const int SE_ECL2HOR = 0;
const int SE_EQU2HOR = 1;
const int SE_HOR2ECL = 0;
const int SE_HOR2EQU = 1;

const int SE_TRUE_TO_APP = 0;
const int SE_APP_TO_TRUE = 1;

const int SE_DE_NUMBER = 406;
const char[] SE_FNAME_DE200 = "de200.eph";
const char[] SE_FNAME_DE403 = "de403.eph";
const char[] SE_FNAME_DE404 = "de404.eph";
const char[] SE_FNAME_DE405 = "de405.eph";
const char[] SE_FNAME_DE406 = "de406.eph";
const char[] SE_FNAME_DFT = SE_FNAME_DE406;
const char[] SE_STARFILE = "fixstars.cat";
const char[] SE_ASTNAMFILE = "seasnam.txt";
const char[] SE_FICTFILE = "seorbel.txt";

const char[] SE_EPHE_PATH = ".:/users/ephe2/:/users/ephe/";

const int SE_SPLIT_DEG_ROUND_SEC = 1;
const int SE_SPLIT_DEG_ROUND_MIN = 2;
const int SE_SPLIT_DEG_ROUND_DEG = 4;
const int SE_SPLIT_DEG_ZODIACAL = 8;
const int SE_SPLIT_DEG_KEEP_SIGN = 16;
const int SE_SPLIT_DEG_KEEP_DEG = 32;


int swe_calc(double tjd, int ipl, int iflag, double* xx, char* serr);
int swe_calc_ut(double tjd_ut, int ipl, int iflag, double* xx, char* serr);
int swe_fixstar(char* star, double tjd, int iflag, double* xx, char* serr);
int swe_fixstar_ut(char* star, double tjd_ut, int iflag, double* xx, char* serr);
void swe_close();
void swe_set_ephe_path(char* path);
void swe_set_jpl_file(char* fname);
char* swe_get_planet_name(int ipl, char* spname);
void swe_set_topo(double geolon, double geolat, double geoalt);
void swe_set_sid_mode(int sid_mode, double t0, double ayan_t0);
double swe_get_ayanamsa(double tjd_et);
double swe_get_ayanamsa_ut(double tjd_ut);
char* swe_get_ayanamsa_name(int isidmode);
int swe_date_conversion(int y, int m, int d, double utime, char c, double* tjd);
double swe_julday(int year, int month, int day, double hour, int gregflag);
void swe_revjul(double jd, int gregflag, int* jyear, int* jmon, int* jday, double* jut);
int swe_houses(double tjd_ut, double geolat, double geolon, int hsys, double* cusps, double* ascmc);
int swe_houses_ex(double tjd_ut, int iflag, double geolat, double geolon, int hsys, double* cusps, double* ascmc);
int swe_houses_armc(double armc, double geolat, double eps, int hsys, double* cusps, double* ascmc);
double swe_house_pos(double armc, double geolat, double eps, int hsys, double* xpin, char* serr);
int swe_gauquelin_sector(double t_ut, int ipl, char* starname, int iflag, int imeth, double* geopos, double atpress, double attemp, double* dgsect, char* serr);
int swe_sol_eclipse_where(double tjd, int ifl, double* geopos, double* attr, char* serr);
int swe_lun_occult_where(double tjd, int ipl, char* starname, int ifl, double* geopos, double* attr, char* serr);
int swe_sol_eclipse_how(double tjd, int ifl, double* geopos, double* attr, char* serr);
int swe_sol_eclipse_when_loc(double tjd_start, int ifl, double* geopos, double* tret, double* attr, int backward, char* serr);
int swe_lun_occult_when_loc(double tjd_start, int ipl, char* starname, int ifl, double* geopos, double* tret, double* attr, int backward, char* serr);
int swe_sol_eclipse_when_glob(double tjd_start, int ifl, int ifltype, double* tret, int backward, char* serr);
int swe_lun_occult_when_glob(double tjd_start, int ipl, char* starname, int ifl, int ifltype, double* tret, int backward, char* serr);
int swe_lun_eclipse_how(double tjd_ut, int ifl, double* geopos, double* attr, char* serr);
int swe_lun_eclipse_when(double tjd_start, int ifl, int ifltype, double* tret, int backward, char* serr);
int swe_pheno(double tjd, int ipl, int iflag, double* attr, char* serr);
int swe_pheno_ut(double tjd_ut, int ipl, int iflag, double* attr, char* serr);
double swe_refrac(double inalt, double atpress, double attemp, int calc_flag);
double swe_refrac_extended(double inalt, double geoalt, double atpress, double attemp, double lapse_rate, int calc_flag, double* dret);
void swe_set_lapse_rate(double lapse_rate);
void swe_azalt(double tjd_ut, int calc_flag, double* geopos, double atpress, double attemp, double* xin, double* xaz);
void swe_azalt_rev(double tjd_ut, int calc_flag, double* geopos, double* xin, double* xout);
int swe_rise_trans(double tjd_ut, int ipl, char* starname, int epheflag, int rsmi, double* geopos, double atpress, double attemp, double* tret, char* serr);
int swe_nod_aps(double tjd_et, int ipl, int iflag, int method, double* xnasc, double* xndsc, double* xperi, double* xaphe, char* serr);
int swe_nod_aps_ut(double tjd_ut, int ipl, int iflag, int method, double* xnasc, double* xndsc, double* xperi, double* xaphe, char* serr);
double swe_deltat(double tjd);
int swe_time_equ(double tjd, double* te, char* serr);
double swe_sidtime0(double tjd_ut, double eps, double nut);
double swe_sidtime(double tjd_ut);
void swe_cotrans(double* xpo, double* xpn, double eps);
void swe_cotrans_sp(double* xpo, double* xpn, double eps);
double swe_get_tid_acc();
void swe_set_tid_acc(double t_acc);
double swe_degnorm(double x);
double swe_radnorm(double x);
double swe_rad_midp(double x1, double x0);
double swe_deg_midp(double x1, double x0);
void swe_split_deg(double ddeg, int roundflag, int* ideg, int* imin, int* isec, double* dsecfr, int* isgn);
int swe_csnorm(int p);
int swe_difcsn(int p1, int p2);
double swe_difdegn(double p1, double p2);
int swe_difcs2n(int p1, int p2);
double swe_difdeg2n(double p1, double p2);
double swe_difrad2n(double p1, double p2);
int swe_csroundsec(int x);
int swe_d2l(double x);
int swe_day_of_week(double jd);
char* swe_cs2timestr(int t, int sep, int suppressZero, char* a);
char* swe_cs2lonlatstr(int t, char pchar, char mchar, char* s);
char* swe_cs2degstr(int t, char* a);


/* End. */
