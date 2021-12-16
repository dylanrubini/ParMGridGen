! FMgridGen.F90
!


module FMgridGen_API
    
    use FMGridGen_Interface

    implicit none

    public :: FMgridGen

contains



    subroutine FMGridGen(nvtxs, xadj, vvol, vsurf, &
              & adjncy, adjwgt, minsize, maxsize,  &
              & options,nmoves, nparts, part)
        use iso_c_binding, only: c_int
        integer(kind=c_int),     intent(in) :: nvtxs, minsize, maxsize !! min/max are upper/lower boundary on coarse graph cell size
            !! The number of vertices in the graph..
        integer(kind=idxtype),   intent(in) :: xadj(:), adjncy(:)
            !! adjacency structure of the graph
        real(kind=realtype),  intent(in) :: vvol(:), vsurf(:)        
            !! information about the volume of each vertex and boundary surface area (zero in interior)
        real(kind=realtype),   intent(in) :: adjwgt(:) 
            !! information about the weights of the edges
        integer(kind=c_int),     intent(in) :: options(MGRIDGEN_OPTIONS)
            !! An array of options as described in Section 5.4 of the METIS manual. See description for valid options.
        integer(kind=c_int),     intent(out) :: nmoves
            !! Upon successful completion, this stores number of move performed in refinement stage
        integer(kind=c_int) ,    intent(out) :: nparts
            !! An array of size `nparts*ncon` that specifies the desired weight for each partition and constraint.
        integer(kind=idxtype),   intent(out) :: part(nvtxs)

        call MGridGen( nvtxs, xadj, vvol, vsurf,adjncy, adjwgt, minsize, maxsize, &
                     & options, nmoves, nparts, part ) 

        if (nparts.le.0) then
            write(*,*) 'no agglomorated cells generated ! - stopping ...'
            stop 
        endif


    end subroutine FMgridGen



end module FMgridGen_API
