$ErrorActionPreference = 'Continue'

& ${env:CONDA}\condabin\conda.bat activate base
cd onedpl && mkdir build && cd build

echo TEST
echo ${env:LIB}
echo ${LIB}
echo TEST

$cmd_args = @"
"C:\Program Files (x86)\Microsoft Visual Studio\2019\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x64 &&
cmake -G "Ninja" -DCMAKE_TOOLCHAIN_FILE=../cmake/windows-dpcpp-toolchain.cmake -DCMAKE_CXX_COMPILER=dpcpp -DONEDPL_BACKEND=dpcpp -DONEDPL_DEVICE_TYPE=CPU .. &&
ninja -j -v &&
ctest --timeout 360 --output-on-failure
"@

${cmd_args} = [string]::join(" ", (${cmd_args}.Split("`n")))
cmd /c ${cmd_args}
exit ${LastExitCode}
