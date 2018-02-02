@echo off

:: Defines the program that will be tested.
::
set PGM_TO_TEST=test-mswin-setmode.exe
for %%d in (. ..) do (
    if exist "%%d\%PGM_TO_TEST%" (
        set REL_PGM_TO_TEST=%%d\%PGM_TO_TEST%
        goto FOUND_PGM_TO_TEST
    )
)
echo Could not find program to test: %PGM_TO_TEST% 1>&2
goto :EOF

:FOUND_PGM_TO_TEST
:: This test assumes that it will be run with the default "code page".
:: See "chcp /?" for more info on that. Anyway, in the default code page,
:: a UTF-8 character is going to be seen as a sequence of bytes, not an
:: acutal character. The THORN_UTF8_BYTES variable represents the 
:: sequence of bytes for the Thorn character when it is encoded in UTF-8.
::
set THORN_UTF8_BYTES=Þ

:: Compares the output of the test with the actual UTF-8 byte encoding of
:: the capital thorn character.
::
for /f %%c in ('%REL_PGM_TO_TEST%') do (
    if "%%c"=="%THORN_UTF8_BYTES%" (
        echo %~n0: Passed
    ) else (
        echo %~n0: Failed: expected "%THORN_UTF8_BYTES%" but received "%%c"
    )
)
