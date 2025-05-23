!RUN: %python %S/../test_errors.py %s %flang -fopenmp
! Positive tests for default(none)
subroutine sb2(x)
  real :: x
end subroutine

subroutine sb1
  integer :: i
  real :: a(10), b(10), k
  inc(x) = x + 1.0
  abstract interface
    function iface(a, b)
      real, intent(in) :: a, b
      real :: iface
    end function
  end interface
  procedure(iface) :: compute
  procedure(iface), pointer :: ptr => NULL()
  ptr => fn2
  !$omp parallel default(none) shared(a,b,k) private(i)
  do i = 1, 10
    b(i) = k + sin(a(i)) + inc(a(i)) + fn1(a(i)) + compute(a(i),k) + add(k, k)
    call sb3(b(i))
    call sb2(a(i))
  end do
  !$omp end parallel
contains
 function fn1(x)
   real :: x, fn1
   fn1 = x
 end function
 function fn2(x, y)
   real, intent(in) :: x, y
   real :: fn2
   fn2 = x + y
 end function
 subroutine sb3(x)
   real :: x
   print *, x
 end subroutine
end subroutine

!construct-name inside default(none)
subroutine sb4
  !$omp parallel default(none)
    loop: do i = 1, 10
    end do loop
  !$omp end parallel
end subroutine

! Test that default(none) does not error for assumed-size array
subroutine sub( aaa)
  real,dimension(*),intent(in)::aaa
  integer::ip
  real::ccc
!$omp parallel do private(ip,ccc) default(none)
  do ip = 1, 10
     ccc= aaa(ip)
  end do
end subroutine sub

! Test that threadprivate variables with host association
! have a predetermined DSA
subroutine host_assoc()
  integer, save :: i
  !$omp threadprivate(i)
  real, save :: r
  !$omp threadprivate(r)
contains
  subroutine internal()
!$omp parallel default(none)
    print *, i, r
!$omp end parallel
  end subroutine internal
end subroutine host_assoc
