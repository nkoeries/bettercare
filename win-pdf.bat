:: Don't show these commands to the user
@ECHO off
:: Set the title of the window
TITLE Bettercare PDF
:: Ask user which folder to process
SET /p book=Which book folder are we processing? 
:: Loop back to this point to refresh the build and PDF
:refresh
:: let the user know we're on it!
ECHO Generating HTML...
:: ...and run Jekyll to build new HTML
CALL bundle exec jekyll build
:: Navigate into the book's folder in _site output
CD _site\%book%
:: Let the user know we're now going to make the PDF
ECHO Creating PDF...
:: Run prince, showing progress (-v), printing the docs in file-list
:: and saving the resulting PDF to the _output folder
:: (For some reason this has to be run with CALL)
CALL prince -v -l file-list -o ..\..\_output\%book%.pdf
:: Navigate back to where we began.
CD ..\..
:: Tell the user we're done
ECHO Done! Opening PDF...
:: Navigate to the _output folder...
CD _output
:: and open the PDF we just created 
:: (`start` so the PDF app opens as a separate process, doesn't hold up this script)
start %book%.pdf
:: Navigate back to where we began.
CD ..\
:: Let the user easily refresh the PDF by running jekyll b and prince again
SET repeat=
SET /p repeat=Enter to run again, or any other key and enter to stop. 
IF "%repeat%"=="" GOTO refresh