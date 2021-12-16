! FMgridGen.F90 -- Fortran MgridGen Interface
!

!
module FMGridGen_Interface

    use iso_c_binding, only: c_int32_t, c_int64_t, c_int, c_float, c_double, c_ptr

    implicit none
    private

    !
    ! Width of elementary data types (should match those used in MgridGen.h)
    !
#ifdef INT64
    integer, parameter, public ::  idxtype = c_int64_t ! <--- modify integer size here (c_int32_t or c_int64_t)
#else
    integer, parameter, public ::  idxtype = c_int32_t ! <--- modify integer size here (c_int32_t or c_int64_t)
#endif

#ifdef REAL64
    integer, parameter, public ::  realtype = c_double  ! <--- modify real size here (c_float or c_double)
#else
    integer, parameter, public ::  realtype = c_float
#endif

    ! Number of MgridGen options
    !
    integer(kind=idxtype), parameter, public :: MGRIDGEN_OPTIONS = 4       !! Number of MgridGen OPTIONS

    !
    integer(kind=idxtype), parameter, public :: OPTION_CTYPE     = 1  !! select algorithm for coarsening phase
    integer(kind=idxtype), parameter, public :: OPTION_RTYPE     = 2  !! select algorithm for refinement phase
    integer(kind=idxtype), parameter, public :: OPTION_DBGLVL    = 3  !! debug level 
    integer(kind=idxtype), parameter, public :: OPTION_DIM       = 4  !! dimension of grid
    !

    !! CType Schemes !!
    integer(kind=idxtype), parameter, public :: MATCH_RM       = 1
    integer(kind=idxtype), parameter, public :: MATCH_HEM      = 2
    integer(kind=idxtype), parameter, public :: MATCH_HEM_SLOW = 3
    integer(kind=idxtype), parameter, public :: MATCH_HEM_TRUE = 4

    !! RType Schemes !!
    integer(kind=idxtype), parameter, public :: REFINE_AR      = 1
    integer(kind=idxtype), parameter, public :: REFINE_WAR     = 2
    integer(kind=idxtype), parameter, public :: REFINE_SCUT    = 3
    integer(kind=idxtype), parameter, public :: REFINE_MINMAXAVAR      =   4
    integer(kind=idxtype), parameter, public :: REFINE_MINMAXAR        =   5
    integer(kind=idxtype), parameter, public :: REFINE_MULTIOBJECTIVE  =   6
    integer(kind=idxtype), parameter, public :: REFINE_MULTIOBJECTIVE2 =   7

    !! Debug Levels !!
    integer(kind=idxtype), parameter, public :: DBG_PROGRESS  =  1       !! If you should show size info per level !!
    integer(kind=idxtype), parameter, public :: DBG_OUTPUT = 2       !! If you should output intermediate partitions !!
    integer(kind=idxtype), parameter, public :: DBG_COARSEN =4
    integer(kind=idxtype), parameter, public :: DBG_REFINE  =8
    integer(kind=idxtype), parameter, public :: DBG_MOVEINFO  =  16
    integer(kind=idxtype), parameter, public :: DBG_MERGE   = 32      !! If you should check merging !!
    integer(kind=idxtype), parameter, public :: DBG_CONTR  = 64      !! If you should check contributing !!
    integer(kind=idxtype), parameter, public :: DBG_TRACK  = 128     !! Track progress; Print Final Results only !!


    ! MgridGen API


    ! Agglomoration multigrid coarsening routines 
    public ::  MGridGen


    interface

    !
    ! Agglomoration multigrid corsening routines
    !

    subroutine MGridGen(nvtxs, xadj, vvol, vsurf, & 
              & adjncy, adjwgt, minsize, maxsize, &
              & options,nmoves, nparts, part) bind(C,name="MGridGen")
        use iso_c_binding, only: c_int
        import idxtype, realtype, MGRIDGEN_OPTIONS
        
        ! Parameters
        integer(kind=c_int), value,intent(in) :: nvtxs, minsize, maxsize !! min/max are upper/lower boundary on coarse graph cell size
            !! The number of vertices in the graph..
        integer(kind=idxtype),   intent(in), dimension(*) :: xadj, adjncy
            !! adjacency structure of the graph
        real(kind=realtype),  intent(in), dimension(*) :: vvol, vsurf        
            !! information about the volume of each vertex and boundary surface area (zero in interior)
        real(kind=realtype),   intent(in), dimension(*)  :: adjwgt 
            !! information about the weights of the edges
        integer(kind=c_int),     intent(in)  :: options(MGRIDGEN_OPTIONS)
            !! An array of options as described in Section 5.4 of the METIS manual. See description for valid options.
        integer(kind=c_int),     intent(out) :: nmoves
            !! Upon successful completion, this stores number of move performed in refinement stage
        integer(kind=c_int) ,    intent(out) :: nparts
            !! An array of size `nparts*ncon` that specifies the desired weight for each partition and constraint.
        integer(kind=idxtype),   intent(out) :: part(nvtxs)
            !! This stores an array equal to size of number of graph vertices. stores 
            !! control volume number that each graph vertex belongs to in coarse graph
    end subroutine MGridGen
!*****************************************************************************************

!*****************************************************************************************
!*****************************************************************************************

    end interface

end module FMGridGen_Interface
!*****************************************************************************************





