#! /bin/bash

##### ?  SHELL SCRIPTING TUTORIAL 

### ? Basic System variable and sleep and clear strat.

# echo $BASH_VERSION
# echo $HOME
# echo $PWD
# sleep 2
# clear



### ? Silent and same prompt 
 
# name=jatin
# read -p "Enter name: " name  # -p flag ensures that input is in same line
# echo my name is $name 
#                             # -sp ensure slient and same promopt
# lok=pass
# read -sp "Enter Password: " lok
# echo
# echo your password is $lok


### *Array flag

# echo "Enter Names: "
# read -a Names       #-a flag implies array
# echo "Names : ${Names[0]}, ${Names[1]} " 


### ? read with no variable

# echo "enter Name:"
# read                #the default variable in which read stores Input from user is REPLY
# echo "Name: $REPLY"

### Passing arguments to bash script
## $0 is always script name [entervalue which execute script]


# echo $1 $2 $3 "/"       #Arguments of bash script are stored in defualt variable, named  $1,$2,$3 and so on   


# args=("$@")   # array storing arguments 

# echo ${args[0]} ${args[1]} ${args[2]} 

# echo $@   #printing all arguments 

# echo $#   #number of arguments


### ? if else in bash 

## * integer comparision
## -eq - is equal to                - if [ $a -eq $b ]
## -ne - is not equal to            - if [ $a -ne $b ]
## -gt - is greater than            - if [ $a -gt $b ]
## -ge - is greater than equal to   - if [ $a -ge $b ]
## -lt - is less than               - if [ $a -eq $b ]
## -le - is less than equal to      - if [ $a -le $b ]
##  <  -  if(($a < $b)) 
##  <= -  if(($a <= $b))
##  >  -  if(($a > $b))
##  >= -  if(($a >= $b))

## *String comparision
## =                                 - if[$a = $b]
## ==                                - if[$a == $b]
## "!="                              - if[$a != $b] {!= is same as above}
##  <  less than in ascii alphabets  - if[[$a < $b]]
##  >  greater than in ascii aphabes - if[[$a > $b]]
## -z  null string (0 length string) - if[$a -z]



##if then fi, if then else fi, if then elif then else fi.

# count=10

# if [ $count == 0 ]
# then
#     echo hero 
# elif (($count == 10)) 
# then
#     echo king
# else 
#     echo lik
# fi


### ? File test operators

##   \c ( with -e ) keeps the cursor on the same line after the echo

# echo -e "Enter the name of the file : \c"
# read file_name


# if [ -e $file_name  ] # here -e operator tells us whether file existed or not
# then
#     echo $file_name found
# else
#     echo $file_name not found
# fi

# if [ -f $file_name  ] # here -f operator tells us whether file (exist and) is regular or not (folder like)
# then
#     echo $file_name found
# else
#     echo $file_name not found
# fi

# if [ -d $file_name  ] # similarly -d checks directory
# then
#     echo $file_name found
# else
#     echo $file_name not found
# fi

## -b :  block special file [ picture, video or executable etc.]
## -c :  character special fie [normal text file which is not configured by program]
## -s : checks whether file is empty or not

## -r : checks that file has read permission or not
## -w : checks that file has write permission or not
## -x : checks that file has execute permission or not

### ? Example (Write a cript to append to a file which already exist)

# echo -e "Enter the name of the file : \c"
# read file_name

# # chmod {- for remove + to add,permissison}{r,w,x} {filename}

# if [ -f $file_name  ] # here -e operator tells us whether file existed or not
# then
#      # check write permission then write echo $file_name found
#      if [ -w $file_name ]
#      then
#         echo "Type some text to append in the file, To quit press ctrl+d ."
#         cat >> $file_name            # to append in same line try : date | tr -d '\n' >> file.txt && echo -n "new data" >> file.txt
#      else   
#         echo $file_name not have write permission
#      fi
# else
#     echo $file_name not found
# fi


### ? AND| OR operators

# echo "Type age"
# read age

# if [ $age -gt 18 -a $age -lt 30 ]   # -a can replace this expesiion [ $age -gt 18 ] && [ $age -lt 30 ]
# then
#     echo "Greater than 18 and less than 30"
# else 
#     echo "Not in range of 18 and 30"
# fi

# if [[ $age -gt 18 && $age -lt 30 ]]   
# then
#     echo "Greater than 18 and less than 30"
# else 
#     echo "Not in range of 18 and 30"
# fi

# if [ $age -gt 18 -o $age -lt 10 ]    # -o can replace this expesiion [ $age -gt 18 ] || [ $age -lt 10 ], [[ $age -gt 18 && $age -lt 10 ]]
# then
#     echo "Greater than 18 or less than 10"
# else 
#     echo "Not Greater than 18 or less than 10"
# fi


### ? Arithmatic operations in shell script 

## Integer
# num1=20
# num2=5

# echo $(( num1 + num2 ))
# echo $(( num1 - num2 ))
# echo $(( num1 * num2 ))
# echo $(( num1 / num2 ))
# echo $(( num1 % num2 ))

# echo $(expr $num1 + $num2 )
# echo $(expr $num1 - $num2 )
# echo $(expr $num1 \* $num2 )  #expr consider * as an error without escape chr "\"
# echo $(expr $num1 / $num2 )
# echo $(expr $num1 % $num2 )

## * Floating point (man bc)

# num1=20.5
# num2=5

# echo " $num1 + $num2 " | bc
# echo " $num1 - $num2 " | bc
# echo " $num1 * $num2 " | bc
# echo " scale=2; $num1 / $num2 " | bc # scale=> number of digits after .
# echo " $num1 % $num2 " | bc

# echo "scale=2; sqrt($num2)" | bc -l  # square root (bc for floating point and -l for linking math lib)
# echo "scale=2; ($num2)^($num2) " | bc -l 

### ? Case statement 

# echo Enter vehicle name
# read vechicle

# vehicle=$1

# case $vehicle in
#     "car" )
#         echo "Rent of $vehicle is 100Rs " ;;
#     "van" )
#         echo "Rent of $vehicle is 80Rs " ;;
#     "cycle" )
#         echo "Rent of $vehicle is 10Rs " ;;
#     "truck" )
#         echo "Rent of $vehicle is 150Rs " ;;
#     * )
#         echo "We can't rent that" ;;
# esac

# echo -e "Enter some character : \c"
# read value
 
# # Set "LANG=C" before entering in bash 

# case $value in
#     [a-z] )
#         echo " $value is small [a-z] " ;;
#     [A-Z] )
#         echo " $value is [A-Z] " ;;
#     [0-9] )
#         echo " $value is [0-9] " ;;
#     ? )
#         echo " $value is special character " ;; # ? waits for 1 character
#     * )
#         echo " Unknown Input " ;;  # * waits for string (of number or alphabets)
# esac


### ? Array Variables

# os=('ubuntu_20.04' 'windows 10' 'kali_linux')

# os[3]="macOs" #addition in array

# unset os[2] #Remove 2nd index from array
# echo "${os[@]}"
# echo "ind 0: ${os[0]} ind 1: ${os[1]} ind 2: ${os[2]}"
# echo "${!os[@]}"  #indices of array
# echo "${#os[@]}"  #length of array

# stri="random_string"
# echo "${stri[0]}"
# echo "${stri[1]}"
# echo "${stri[2]}"

### ? While Loops

# n=1
# while (( $n <= 10 ))
# do 
#     echo "$n"
#     n=$(( n+1 )) # (( n++ )) or (( ++n ))
# done

### ? sleep and open terminal with while loops

## * sleep (delay in sec)

# n=1
# while (( $n <= 3 ))
# do 
#     echo "$n"
#     n=$(( n+1 )) # (( n++ )) or (( ++n ))
#     gnome-terminal &
# done

### ? Read file with while loop

# while read p 
# do 
#     echo $p
# done < hello.sh

# cat hello.sh | while read p 
# do 
#     echo $p
# done

## * using IFS (internal field seperator)

# while IFS= read -r p  #-r to not interpret \ # IFS=' * ' read -r p
# do 
#     echo $p
# done < hello.sh

### ? UNTIL Loops

# n=1

# until (( $n>10 )) #loops only when condition is false/ opposite of while loop
# do  
#     echo $n
#     (( n++ ))

# done 

### ? For Loops

# #* T1
# for VARIABLE in 1 2 3 4 5 .. N
# do 
#     command 1
#     command 2
# done

# #* T2
# for VARIABLE in file1 file2 file3
# do 
#     command1 on $VARIABLE
#     command2
# done 

# #* T3
# for OUTPUT in $(Linux-Or-Unix-Command-Here)
# do 
#     command1 on $OUTPUT
#     command2 on $OUTPUT
#     command3
# done 

# #* T4
# for (( EXP1; EXP2; EXP3 )) #(int i=0;i<n;i++)
# do 
#     command1
#     command2
#     command3
# done

## *Eg1
# for (( i=1; i<=10; i++ ))
# do
#     echo $i 
# done


## *Eg2

# for i in 1 2 3 4 5 6 7 8 9 10 #iterate over 1 to 10
# do 
#     echo $i

# done

# for i in {1..10..2} #iterate over 1 to 10 {START..END..INCREMENT} WORks in BASH VERSION 4 and upper
# do 
#     echo $i

# done


## *Eg3

# for command in ls pwd date
# do 
#     echo "---------$command-------------"
#     $command
# done

# for item in *       # * checks the strings in pwd if they are directory we print them
# do 
#     if [ -d $item ]
#     then   
#         echo $item    
#     fi
# done

# for item in ?
# do 
#     if [ -d $item ]
#     then   
#         echo $item    
#     fi
# done

### ? Select Loop

# select name in john_cena steve_austin the_rock Hero 
# do  
#     echo "$name selected"
# done


# select name in john_cena steve_austin the_rock Hero quit
# do  
#     case $name in 
#     john_cena)
#         echo You cant see him ;;
#     the_rock)
#         echo most electrifying man ;;
#     steve_austin)
#         echo Fear the Bear ;;
#     Hero)
#         echo Joy ke sath hum moj manaye ;;
#     quit)
#         break ;; # conitinue skip the execution and goes to iteration again
#     *)
#         echo "please provide number from above"
#     esac
# done

### ? Functions

##* T1

# function name(){
#     commands
# }

##* T2
# name (){
#     commands
# }

# function Hello(){
#     echo Hellobc
# }

# quit(){
#     echo "Exiting shell"
#     exit
# }

# Hello
# quit

##* Local Variable

# function Hello(){
#     local name=$1       #to make local variable add local keyword
#     echo "Name is $name"
# }

# name="Tom"
# echo "Name is $name"

# Hello Mad

# echo "Name is $name"

##* Example of function

# usage(){
#     echo "Provide some argument"
#     echo "usage : $0 file_name"
#     exit
# }

# function FileExist(){
#     local file_name=$1
#     [[ -f "$file_name" ]] && return 0 || return 1  #ternary operator in scrit
# }   

## * Ternary operator example
## n=10
## [[ $n -eq 0 ]] && echo "Ten" || echo "not Ten"


# [[ $# -eq 0 ]] && usage

# if ( FileExist "$1" )
# then 
#     echo "File Found"
# else
#     echo "File not Found"
# fi

###? Read Only Command

##* Readonly variable
# var=31
# readonly var
# ## var=42  #Var is readonly so it cant be overwritten 

# echo "var => $var"

##* Readonly function
# hello(){
#     echo "hello world"
# }

# readonly -f hello
# hello 

###? Signals and Traps

# trap "echo Exit command is detected " 0
# echo " Hello World "
# exit 0

## $$ prints pid of script


##* Removal of file on getting success SIGINT or SIGTERM signal 


# set -x # start debugger from here

# set +x # stop debugger at this line

# filename=0.txt
# touch $filename
# file=$PWD/$filename

# trap "rm -f $file && echo $filename Deleted ; exit" 0 SIGINT SIGTERM  #Trap cant catch SIGKILL and SIGSTOP

# echo "pid is $$"
# while (( COUNT < 10 ))
# do
#     sleep 3
#     (( COUNT ++ ))
#     echo $COUNT
# done
# exit 0

## trap - signal_name/value to remove traps

###? Shell Debugger
##* 1.
##* bash -x name_of_script

##* 2.
##* #!/bin/bash -x at top

##* 3.
##* set -x
