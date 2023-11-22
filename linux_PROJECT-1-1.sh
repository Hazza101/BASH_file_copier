#!/bin/bash


#setting command line parameter to a variable named filename

filename=$1



#this section checks if the user entered 0 parameters
 

if [ -z "$filename" ];
then

	#if the user entered no parameters, it requests a source and destination folder and then stores the user input in a file
	#this file is used in the while loop below so I don't have to repeat certain checks (whether source folder exists or destination already exist) 
	
	
	echo enter a source folder
	read sourceFolder
	echo enter a destination folder
	read destinationFolder
	touch tmp101.txt
	echo $sourceFolder $destinationFolder > tmp101.txt
	filename=tmp101.txt


fi


#this section checks if the user entered more than one command line parameter
#if the user has entered 2 or more, it asks them to try again (specifying the error) and then ends the bash file

if ! [ -z "$2" ];
then
	echo too many parameters
	echo please try again
	exit 0
fi


#this while loop cycles through each line in the list.txt. It checks whether the source folder exists and if the destination folder already exists.
#if eveything is alright then it copies the source folder into the destination folder
#here I assign "filename" variable to file descriptor3 so that the read command within the loop does not confuse data streams 


while read var1 var2 <&3;
do

	#here I use the variable answer to allow me to decide later on whether or not to copy 
	
	echo ---------------------------
	answer=y
	
	#this part checks if the source folder exists
	#if not then it continues to the next line in the list.txt file	
	
	if ! [ -d $var1 ];
	then
		echo Source folder &var1 does not exist
		continue
	fi
	

	#this checks if the destination folder already exists
	#if it does then it asks whether or not to overwrite the existing file
	#it stores the users response in the answer variable we declared as "y" above 
	
	if [ -d $var2 ];
	then
		echo Destination folder $var2 already exists
		echo "do you want to overwrite?(y/n)"
		read response
		answer=$response
	       	 	
	fi
	
	#if the destination folder does not exist then this part will be skipped
	#however if the folder already exists and the user does not want to overwrite it, it will be activated and skip to the next line in list.txt
	
	if   [ "$answer" = "n" ];
	then
		
		continue
	fi
	
	
	echo $var1 copied to $var2
	
	cp -r $var1 $var2 
		



done 3< $filename

#ls

#rm -r destination1 destination2 destination3 destination4 destination5 destination6 
