/**
 * D bindings for AstroDienst Swiss Ephemeris library.
 *
 * Author: Stanislas Marquis <stnsls@gmail.com>
 * Swisseph version: 1.76.00
 * Date: 03.06.2009
 */

module swisseph;

extern (C):

/************************************************************
  $Header: /home/dieter/sweph/RCS/swephexp.h,v 1.74 2008/06/16 10:07:20 dieter Exp $
  SWISSEPH: exported definitions and constants

  This file represents the standard application interface (API)
  to the Swiss Ephemeris.

  A C programmer needs only to include this file, and link his code
  with the SwissEph library.

  The function calls are documented in the Programmer's documentation,
  which is online in HTML format.

  Structure of this file:
    Public API definitions
    Internal developer's definitions
    Public API functions.

  Authors: Dieter Koch and Alois Treindl, Astrodienst Zürich

************************************************************/
/* Copyright (C) 1997 - 2008 Astrodienst AG, Switzerland.  All rights reserved.

  License conditions
  ------------------

  This file is part of Swiss Ephemeris.

  Swiss Ephemeris is distributed with NO WARRANTY OF ANY KIND.  No author
  or distributor accepts any responsibility for the consequences of using it,
  or for whether it serves any particular purpose or works at all, unless he
  or she says so in writing.

  Swiss Ephemeris is made available by its authors under a dual licensing
  system. The software developer, who uses any part of Swiss Ephemeris
  in his or her software, must choose between one of the two license models,
  which are
  a) GNU public license version 2 or later
  b) Swiss Ephemeris Professional License

  The choice must be made before the software developer distributes software
  containing parts of Swiss Ephemeris to others, and before any public
  service using the developed software is activated.

  If the developer choses the GNU GPL software license, he or she must fulfill
  the conditions of that license, which includes the obligation to place his
  or her whole software project under the GNU GPL or a compatible license.
  See http://www.gnu.org/licenses/old-licenses/gpl-2.0.html

  If the developer choses the Swiss Ephemeris Professional license,
  he must follow the instructions as found in http://www.astro.com/swisseph/
  and purchase the Swiss Ephemeris Professional Edition from Astrodienst
  and sign the corresponding license contract.

  The License grants you the right to use, copy, modify and redistribute
  Swiss Ephemeris, but only under certain conditions described in the License.
  Among other things, the License requires that the copyright notices and
  this notice be preserved on all copies.

  Authors of the Swiss Ephemeris: Dieter Koch and Alois Treindl

  The authors of Swiss Ephemeris have no control or influence over any of
  the derived works, i.e. over software or services created by other
  programmers which use Swiss Ephemeris functions.

  The names of the authors or of the copyright holder (Astrodienst) must not
  be used for promoting any software, product or service which uses or contains
  the Swiss Ephemeris. This copyright notice is the ONLY place where the
  names of the authors can legally appear, except in cases where they have
  given special permission in writing.

  The trademarks 'Swiss Ephemeris' and 'Swiss Ephemeris inside' may be used
  for promoting such software, products or services.
*/

/***********************************************************
 * definitions for use also by non-C programmers
 ***********************************************************/

/* values for gregflag in swe_julday() and swe_revjul() */
const SE_JUL_CAL        = 0;
const SE_GREG_CAL       = 1;

/*
 * planet numbers for the ipl parameter in swe_calc()
 */
const SE_ECL_NUT        = -1;

const SE_SUN            = 0;
const SE_MOON           = 1;
const SE_MERCURY        = 2;
const SE_VENUS          = 3;
const SE_MARS           = 4;
const SE_JUPITER        = 5;
const SE_SATURN         = 6;
const SE_URANUS         = 7;
const SE_NEPTUNE        = 8;
const SE_PLUTO          = 9;
const SE_MEAN_NODE      = 10;
const SE_TRUE_NODE      = 11;
const SE_MEAN_APOG      = 12;
const SE_OSCU_APOG      = 13;
const SE_EARTH          = 14;
const SE_CHIRON         = 15;
const SE_PHOLUS         = 16;
const SE_CERES          = 17;
const SE_PALLAS         = 18;
const SE_JUNO           = 19;
const SE_VESTA          = 20;
const SE_INTP_APOG      = 21;
const SE_INTP_PERG      = 22;

const SE_NPLANETS       = 23;

const SE_AST_OFFSET     = 10000;
const SE_VARUNA         = SE_AST_OFFSET + 20000;

const SE_FICT_OFFSET    = 40;
const SE_FICT_OFFSET_1  = 39;
const SE_FICT_MAX       = 999;
const SE_NFICT_ELEM     = 15;

const SE_COMET_OFFSET   = 1000;

const SE_NALL_NAT_POINTS = SE_NPLANETS + SE_NFICT_ELEM;

/* Hamburger or Uranian "planets" */
const SE_CUPIDO         = 40;
const SE_HADES          = 41;
const SE_ZEUS           = 42;
const SE_KRONOS         = 43;
const SE_APOLLON        = 44;
const SE_ADMETOS        = 45;
const SE_VULKANUS       = 46;
const SE_POSEIDON       = 47;
/* other fictitious bodies */
const SE_ISIS           = 48;
const SE_NIBIRU         = 49;
const SE_HARRINGTON     = 50;
const SE_NEPTUNE_LEVERRIER  = 51;
const SE_NEPTUNE_ADAMS      = 52;
const SE_PLUTO_LOWELL       = 53;
const SE_PLUTO_PICKERING    = 54;
const SE_VULCAN         = 55;
const SE_WHITE_MOON     = 56;
const SE_PROSERPINA     = 57;
const SE_WALDEMATH      = 58;

const SE_FIXSTAR        = -10;

const SE_ASC            = 0;
const SE_MC             = 1;
const SE_ARMC           = 2;
const SE_VERTEX     = 3;
const SE_EQUASC     = 4;   /* "equatorial ascendant" */
const SE_COASC1     = 5;   /* "co-ascendant" (W. Koch) */
const SE_COASC2     = 6;   /* "co-ascendant" (M. Munkasey) */
const SE_POLASC     = 7;   /* "polar ascendant" (M. Munkasey) */
const SE_NASCMC     = 8;

/*
 * flag bits for parameter iflag in function swe_calc()
 * The flag bits are defined in such a way that iflag = 0 delivers what one
 * usually wants:
 *    - the default ephemeris (SWISS EPHEMERIS) is used,
 *    - apparent geocentric positions referring to the true equinox of date
 *      are returned.
 * If not only coordinates, but also speed values are required, use
 * flag = SEFLG_SPEED.
 *
 * The 'L' behind the number indicates that 32-bit integers (Long) are used.
 */
const SEFLG_JPLEPH      = 1;       /* use JPL ephemeris */
const SEFLG_SWIEPH      = 2;       /* use SWISSEPH ephemeris */
const SEFLG_MOSEPH      = 4;       /* use Moshier ephemeris */

const SEFLG_HELCTR      = 8;      /* return heliocentric position */
const SEFLG_TRUEPOS     = 16;     /* return true positions, not apparent */
const SEFLG_J2000       = 32;     /* no precession, i.e. give J2000 equinox */
const SEFLG_NONUT       = 64;     /* no nutation, i.e. mean equinox of date */
const SEFLG_SPEED3      = 128;     /* speed from 3 positions (do not use it,
                                  SEFLG_SPEED is faster and more precise.) */
const SEFLG_SPEED       = 256;     /* high precision speed  */
const SEFLG_NOGDEFL     = 512;     /* turn off gravitational deflection */
const SEFLG_NOABERR     = 1024;    /* turn off 'annual' aberration of light */
const SEFLG_EQUATORIAL  = (2*1024);    /* equatorial positions are wanted */
const SEFLG_XYZ         = (4*1024);    /* cartesian, not polar, coordinates */
const SEFLG_RADIANS     = (8*1024);    /* coordinates in radians, not degrees */
const SEFLG_BARYCTR     = (16*1024);   /* barycentric positions */
const SEFLG_TOPOCTR     = (32*1024);   /* topocentric positions */
const SEFLG_SIDEREAL    = (64*1024);   /* sidereal positions */
const SEFLG_ICRS        = (128*1024);   /* ICRS (DE406 reference frame) */

const SE_SIDBITS        = 256;
/* for projection onto ecliptic of t0 */
const SE_SIDBIT_ECL_T0  = 256;
/* for projection onto solar system plane */
const SE_SIDBIT_SSY_PLANE   = 512;

/* sidereal modes (ayanamsas) */
const SE_SIDM_FAGAN_BRADLEY     = 0;
const SE_SIDM_LAHIRI            = 1;
const SE_SIDM_DELUCE            = 2;
const SE_SIDM_RAMAN             = 3;
const SE_SIDM_USHASHASHI        = 4;
const SE_SIDM_KRISHNAMURTI      = 5;
const SE_SIDM_DJWHAL_KHUL       = 6;
const SE_SIDM_YUKTESHWAR        = 7;
const SE_SIDM_JN_BHASIN         = 8;
const SE_SIDM_BABYL_KUGLER1     = 9;
const SE_SIDM_BABYL_KUGLER2     = 10;
const SE_SIDM_BABYL_KUGLER3     = 11;
const SE_SIDM_BABYL_HUBER       = 12;
const SE_SIDM_BABYL_ETPSC       = 13;
const SE_SIDM_ALDEBARAN_15TAU   = 14;
const SE_SIDM_HIPPARCHOS        = 15;
const SE_SIDM_SASSANIAN         = 16;
const SE_SIDM_GALCENT_0SAG      = 17;
const SE_SIDM_J2000             = 18;
const SE_SIDM_J1900             = 19;
const SE_SIDM_B1950             = 20;
const SE_SIDM_USER              = 255;

const SE_NSIDM_PREDEF           = 21;

/* used for swe_nod_aps(): */
const SE_NODBIT_MEAN        = 1;    /* mean nodes/apsides */
const SE_NODBIT_OSCU        = 2;    /* osculating nodes/apsides */
const SE_NODBIT_OSCU_BAR    = 4;    /* same, but motion about solar system barycenter is considered */
const SE_NODBIT_FOPOINT     = 256;  /* focal point of orbit instead of aphelion */

/* default ephemeris used when no ephemeris flagbit is set */
const SEFLG_DEFAULTEPH      = SEFLG_SWIEPH;

const SE_MAX_STNAME         = 256; /* maximum size of fixstar name;
                                   * the parameter star in swe_fixstar
                                   * must allow twice this space for
                                   * the returned star name.
                                   */

/* defines for eclipse computations */

const SE_ECL_CENTRAL        = 1;
const SE_ECL_NONCENTRAL     = 2;
const SE_ECL_TOTAL          = 4;
const SE_ECL_ANNULAR        = 8;
const SE_ECL_PARTIAL        = 16;
const SE_ECL_ANNULAR_TOTAL  = 32;
const SE_ECL_PENUMBRAL      = 64;
const SE_ECL_ALLTYPES_SOLAR = (SE_ECL_CENTRAL|SE_ECL_NONCENTRAL|SE_ECL_TOTAL|SE_ECL_ANNULAR|SE_ECL_PARTIAL|SE_ECL_ANNULAR_TOTAL);
const SE_ECL_ALLTYPES_LUNAR = (SE_ECL_TOTAL|SE_ECL_PARTIAL|SE_ECL_PENUMBRAL);
const SE_ECL_VISIBLE        = 128;
const SE_ECL_MAX_VISIBLE    = 256;
const SE_ECL_1ST_VISIBLE    = 512;
const SE_ECL_2ND_VISIBLE    = 1024;
const SE_ECL_3RD_VISIBLE    = 2048;
const SE_ECL_4TH_VISIBLE    = 4096;
const SE_ECL_ONE_TRY        = (32*1024);
        /* check if the next conjunction of the moon with
         * a planet is an occultation; don't search further */

/* for swe_rise_transit() */
const SE_CALC_RISE          = 1;
const SE_CALC_SET           = 2;
const SE_CALC_MTRANSIT      = 4;
const SE_CALC_ITRANSIT      = 8;
const SE_BIT_DISC_CENTER    = 256; /* to be or'ed to SE_CALC_RISE/SET */
                    /* if rise or set of disc center is */
                    /* required */
const SE_BIT_NO_REFRACTION  = 512; /* to be or'ed to SE_CALC_RISE/SET, */
                    /* if refraction is not to be considered */
const SE_BIT_CIVIL_TWILIGHT = 1024; /* to be or'ed to SE_CALC_RISE/SET */
const SE_BIT_NAUTIC_TWILIGHT    = 2048; /* to be or'ed to SE_CALC_RISE/SET */
const SE_BIT_ASTRO_TWILIGHT     = 4096; /* to be or'ed to SE_CALC_RISE/SET */


/* for swe_azalt() and swe_azalt_rev() */
const SE_ECL2HOR        = 0;
const SE_EQU2HOR        = 1;
const SE_HOR2ECL        = 0;
const SE_HOR2EQU        = 1;

/* for swe_refrac() */
const SE_TRUE_TO_APP    = 0;
const SE_APP_TO_TRUE    = 1;

/*
 * only used for experimenting with various JPL ephemeris files
 * which are available at Astrodienst's internal network
 */
const SE_DE_NUMBER      = 406;
const char[] SE_FNAME_DE200    = "de200.eph";
const char[] SE_FNAME_DE403    = "de403.eph";
const char[] SE_FNAME_DE404    = "de404.eph";
const char[] SE_FNAME_DE405    = "de405.eph";
const char[] SE_FNAME_DE406    = "de406.eph";
const char[] SE_FNAME_DFT      = SE_FNAME_DE406;
const char[] SE_STARFILE       = "fixstars.cat";
const char[] SE_ASTNAMFILE     = "seasnam.txt";
const char[] SE_FICTFILE       = "seorbel.txt";

/*
 * ephemeris path
 * this defines where ephemeris files are expected if the function
 * swe_set_ephe_path() is not called by the application.
 * Normally, every application should make this call to define its
 * own place for the ephemeris files.
 */

version ( Windows )
{
    version( PAIR_SWEPH )
    {
    const char[] SE_EPHE_PATH   = "\\pair\\ephe\\";
    }
    else
    {
    const char[] SE_EPHE_PATH   = "\\sweph\\ephe\\";
    }
}
version ( OSX )
{
const char[] SE_EPHE_PATH   = ":ephe:";
}
version ( linux )
{
const char[] SE_EPHE_PATH   = ".:/usr/share/swisseph/:/usr/local/share/swisseph/";
}


/* defines for function swe_split_deg() (in swephlib.c) */
const SE_SPLIT_DEG_ROUND_SEC    = 1;
const SE_SPLIT_DEG_ROUND_MIN    = 2;
const SE_SPLIT_DEG_ROUND_DEG    = 4;
const SE_SPLIT_DEG_ZODIACAL     = 8;
const SE_SPLIT_DEG_KEEP_SIGN    = 16;    /* don't round to next sign,
                     * e.g. 29.9999999 will be rounded
                     * to 29°59'59" (or 29°59' or 29°) */
const SE_SPLIT_DEG_KEEP_DEG     = 32;    /* don't round to next degree
                     * e.g. 13.9999999 will be rounded
                     * to 13°59'59" (or 13°59' or 13°) */

/* for heliacal functions */
const SE_HELIACAL_RISING        = 1;
const SE_HELIACAL_SETTING       = 2;
const SE_MORNING_FIRST          = SE_HELIACAL_RISING;
const SE_EVENING_LAST           = SE_HELIACAL_SETTING;
const SE_EVENING_FIRST          = 3;
const SE_MORNING_LAST           = 4;
const SE_ACRONYCHAL_RISING      = 5;  /* still not implemented */
const SE_COSMICAL_SETTING       = 6;  /* still not implemented */
const SE_ACRONYCHAL_SETTING     = SE_COSMICAL_SETTING;

const SE_HELFLAG_LONG_SEARCH    = 128;
const SE_HELFLAG_HIGH_PRECISION = 256;
const SE_HELFLAG_OPTICAL_PARAMS = 512;
const SE_HELFLAG_NO_DETAILS     = 1024;
const SE_HELFLAG_AVKIND_VR      = 2048;
const SE_HELFLAG_AVKIND_PTO     = 4096;
const SE_HELFLAG_AVKIND_MIN7    = 8192;
const SE_HELFLAG_AVKIND_MIN9    = 16384;
const SE_HELFLAG_AVKIND = (SE_HELFLAG_AVKIND_VR|SE_HELFLAG_AVKIND_PTO|SE_HELFLAG_AVKIND_MIN7|SE_HELFLAG_AVKIND_MIN9);
const TJD_INVALID       = 99999999.0;
const SIMULATE_VICTORVB = 1;

const SE_PHOTOPIC_FLAG  = 0;
const SE_SCOTOPIC_FLAG  = 1;
const SE_MIXEDOPIC_FLAG = 2;

/*
 * by compiling with -DPAIR_SWEPH in the compiler options it
 * is possible to create a more compact version of SwissEph which
 * contains no code for the JPL ephemeris file and for the builtin
 * Moshier ephemeris.
 * This is quite useful for MSDOS real mode applications which need to
 * run within 640 kb.
 * The option is called PAIR_SWEPH because it was introduced for
 * Astrodienst's partner software PAIR.
 */
version ( PAIR_SWEPH )
{
const bool NO_JPL = true;
}



/***********************************************************
 * exported functions
 ***********************************************************/

int swe_heliacal_ut(double tjdstart_ut, double *geopos, double *datm, double *dobs, char *ObjectName, int TypeEvent, int iflag, double *dret, char *serr);
int swe_heliacal_pheno_ut(double tjd_ut, double *geopos, double *datm, double *dobs, char *ObjectName, int TypeEvent, int helflag, double *darr, char *serr);
int swe_vis_limit_mag(double tjdut, double *geopos, double *datm, double *dobs, char *ObjectName, int helflag, double *dret, char *serr);
/* the following are secret, for Victor Reijs' */
int swe_heliacal_angle(double tjdut, double *dgeo, double *datm, double *dobs, int helflag, double mag, double azi_obj, double azi_sun, double azi_moon, double alt_moon, double *dret, char *serr);
int swe_topo_arcus_visionis(double tjdut, double *dgeo, double *datm, double *dobs, int helflag, double mag, double azi_obj, double alt_obj, double azi_sun, double azi_moon, double alt_moon, double *dret, char *serr);

/****************************
 * exports from sweph.c
 ****************************/

char* swe_version(char *);

/* planets, moon, nodes etc. */
int swe_calc(
        double tjd, int ipl, int iflag,
        double *xx,
        char *serr);

int swe_calc_ut(double tjd_ut, int ipl, int iflag,
    double *xx, char *serr);

/* fixed stars */
int swe_fixstar(
        char *star, double tjd, int iflag,
        double *xx,
        char *serr);

int swe_fixstar_ut(char *star, double tjd_ut, int iflag,
    double *xx, char *serr);

int swe_fixstar_mag(char *star, double *mag, char *serr);

/* close Swiss Ephemeris */
void swe_close();

/* set directory path of ephemeris files */
void swe_set_ephe_path(char *path);

/* set file name of JPL file */
void swe_set_jpl_file(char *fname);

/* get planet name */
char* swe_get_planet_name(int ipl, char *spname);

/* set geographic position of observer */
void swe_set_topo(double geolon, double geolat, double geoalt);

/* set sidereal mode */
void swe_set_sid_mode(int sid_mode, double t0, double ayan_t0);

/* get ayanamsa */
double swe_get_ayanamsa(double tjd_et);

double swe_get_ayanamsa_ut(double tjd_ut);

char* swe_get_ayanamsa_name(int isidmode);

/****************************
 * exports from swedate.c
 ****************************/

int swe_date_conversion(
        int y , int m , int d ,         /* year, month, day */
        double utime,   /* universal time in hours (decimal) */
        char c,         /* calendar g[regorian]|j[ulian] */
        double *tjd);

double swe_julday(
        int year, int month, int day, double hour,
        int gregflag);

void swe_revjul (
        double jd,
        int gregflag,
        int *jyear, int *jmon, int *jday, double *jut);

int swe_utc_to_jd(
        int iyear, int imonth, int iday,
    int ihour, int imin, double dsec,
    int gregflag, double *dret, char *serr);

void swe_jdet_to_utc(
        double tjd_et, int gregflag,
    int *iyear, int *imonth, int *iday,
    int *ihour, int *imin, double *dsec);

void swe_jdut1_to_utc(
        double tjd_ut, int gregflag,
    int *iyear, int *imonth, int *iday,
    int *ihour, int *imin, double *dsec);

/****************************
 * exports from swehouse.c
 ****************************/

int swe_houses(
        double tjd_ut, double geolat, double geolon, int hsys,
    double *cusps, double *ascmc);

int swe_houses_ex(
        double tjd_ut, int iflag, double geolat, double geolon, int hsys,
    double *cusps, double *ascmc);

int swe_houses_armc(
        double armc, double geolat, double eps, int hsys,
    double *cusps, double *ascmc);

double swe_house_pos(
    double armc, double geolat, double eps, int hsys, double *xpin, char *serr);

/****************************
 * exports from swecl.c
 ****************************/

int swe_gauquelin_sector(double t_ut, int ipl, char *starname, int iflag, int imeth, double *geopos, double atpress, double attemp, double *dgsect, char *serr);

/* computes geographic location and attributes of solar
 * eclipse at a given tjd */
int swe_sol_eclipse_where(double tjd, int ifl, double *geopos, double *attr, char *serr);

int swe_lun_occult_where(double tjd, int ipl, char *starname, int ifl, double *geopos, double *attr, char *serr);

/* computes attributes of a solar eclipse for given tjd, geolon, geolat */
int swe_sol_eclipse_how(double tjd, int ifl, double *geopos, double *attr, char *serr);

/* finds time of next local eclipse */
int swe_sol_eclipse_when_loc(double tjd_start, int ifl, double *geopos, double *tret, double *attr, int backward, char *serr);

int swe_lun_occult_when_loc(double tjd_start, int ipl, char *starname, int ifl,
     double *geopos, double *tret, double *attr, int backward, char *serr);

/* finds time of next eclipse globally */
int swe_sol_eclipse_when_glob(double tjd_start, int ifl, int ifltype,
     double *tret, int backward, char *serr);

/* finds time of next occultation globally */
int swe_lun_occult_when_glob(double tjd_start, int ipl, char *starname, int ifl, int ifltype,
     double *tret, int backward, char *serr);

/* computes attributes of a lunar eclipse for given tjd */
int swe_lun_eclipse_how(
          double tjd_ut,
          int ifl,
          double *geopos,
          double *attr,
          char *serr);

int swe_lun_eclipse_when(double tjd_start, int ifl, int ifltype,
     double *tret, int backward, char *serr);

/* planetary phenomena */
int swe_pheno(double tjd, int ipl, int iflag, double *attr, char *serr);

int swe_pheno_ut(double tjd_ut, int ipl, int iflag, double *attr, char *serr);

double swe_refrac(double inalt, double atpress, double attemp, int calc_flag);

double swe_refrac_extended(double inalt, double geoalt, double atpress, double attemp, double lapse_rate, int calc_flag, double *dret);

void swe_set_lapse_rate(double lapse_rate);

void swe_azalt(
      double tjd_ut,
      int calc_flag,
      double *geopos,
      double atpress,
      double attemp,
      double *xin,
      double *xaz);

void swe_azalt_rev(
      double tjd_ut,
      int calc_flag,
      double *geopos,
      double *xin,
      double *xout);

int swe_rise_trans(
               double tjd_ut, int ipl, char *starname,
           int epheflag, int rsmi,
               double *geopos,
           double atpress, double attemp,
               double *tret,
               char *serr);

int swe_nod_aps(double tjd_et, int ipl, int iflag,
                      int  method,
                      double *xnasc, double *xndsc,
                      double *xperi, double *xaphe,
                      char *serr);

int swe_nod_aps_ut(double tjd_ut, int ipl, int iflag,
                      int  method,
                      double *xnasc, double *xndsc,
                      double *xperi, double *xaphe,
                      char *serr);


/****************************
 * exports from swephlib.c
 ****************************/

/* delta t */
double swe_deltat(double tjd);

/* equation of time */
int swe_time_equ(double tjd, double *te, char *serr);

/* sidereal time */
double swe_sidtime0(double tjd_ut, double eps, double nut);
double swe_sidtime(double tjd_ut);

/* coordinate transformation polar -> polar */
void swe_cotrans(double *xpo, double *xpn, double eps);
void swe_cotrans_sp(double *xpo, double *xpn, double eps);

/* tidal acceleration to be used in swe_deltat() */
double swe_get_tid_acc();
void swe_set_tid_acc(double t_acc);

double swe_degnorm(double x);
double swe_radnorm(double x);
double swe_rad_midp(double x1, double x0);
double swe_deg_midp(double x1, double x0);

void swe_split_deg(double ddeg, int roundflag, int *ideg, int *imin, int *isec, double *dsecfr, int *isgn);

/*******************************************************
 * other functions from swephlib.c;
 * they are not needed for Swiss Ephemeris,
 * but may be useful to former Placalc users.
 ********************************************************/

/* normalize argument into interval [0..DEG360] */
int swe_csnorm(int p);

/* distance in centisecs p1 - p2 normalized to [0..360[ */
int swe_difcsn (int p1, int p2);

double swe_difdegn (double p1, double p2);

/* distance in centisecs p1 - p2 normalized to [-180..180[ */
int swe_difcs2n(int p1, int p2);

double swe_difdeg2n(double p1, double p2);
double swe_difrad2n(double p1, double p2);

/* round second, but at 29.5959 always down */
int swe_csroundsec(int x);

/* double to int with rounding, no overflow check */
int swe_d2l(double x);

/* monday = 0, ... sunday = 6 */
int swe_day_of_week(double jd);

char* swe_cs2timestr(int t, int sep, int suppressZero, char *a);

char* swe_cs2lonlatstr(int t, char pchar, char mchar, char *s);

char* swe_cs2degstr(int t, char *a);

