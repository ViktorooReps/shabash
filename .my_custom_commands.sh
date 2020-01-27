#!/bin/bash

# utilities path
UT_PATH=/home/viktor/Documents/utilities/

function comp_rt() {
	local SRC_PATH=runtime_comparison/compare_runtime.py
	python3 $UT_PATH$SRC_PATH $@
}

function crun() {
	local BUILD_CONFIG_PATH=c_files_management/run_config/build_config.txt
	local BUILD_STATUS_PATH=c_files_management/run_config/build_status.txt

	if [ $1 = "config" ] 
	then
		if [ "$2" = "-b" ]
		then
			local BUILD_STATUS_FILE=$UT_PATH$BUILD_STATUS_PATH
			echo $3 > $BUILD_STATUS_FILE
		else
			local BUILD_CONFIG_FILE=$UT_PATH$BUILD_CONFIG_PATH
			echo $2 > $BUILD_CONFIG_FILE
		fi
	elif [ $1 = "info" ]
	then
		local BUILD_STATUS_FILE=$UT_PATH$BUILD_STATUS_PATH
		local BUILD_CONFIG_FILE=$UT_PATH$BUILD_CONFIG_PATH

		echo BUILD_STATUS `cat $BUILD_STATUS_FILE`
		echo BUILD_CONFIG `cat $BUILD_CONFIG_FILE`
	else
		local BUILD_STATUS=`cat $UT_PATH$BUILD_STATUS_PATH`
		if [ $BUILD_STATUS = true ]
		then
			local build_config=`cat $UT_PATH$BUILD_CONFIG_PATH`
			local c_filename=$1
			local o_filename=${c_filename:0:(${#c_filename} - 2)}
			
			$build_config $c_filename -o $o_filename
			if [ $? -eq 0 ]
			then
				./$o_filename
			fi
		elif [ $BUILD_STATUS = false ]
		then
			./$1
		fi
	fi
}

function goto() {
	local LABELS_STORAGE_PATH=goto_configs/labels.txt
	local PATHS_STORAGE_PATH=goto_configs/paths.txt

	if [ $1 = add ]
	then
		local LABELS_STORAGE_FILE=$UT_PATH$LABELS_STORAGE_PATH
		local PATHS_STORAGE_FILE=$UT_PATH$PATHS_STORAGE_PATH

		local all_labels=`cat $LABELS_STORAGE_FILE`
		local all_paths=`cat $PATHS_STORAGE_FILE`

		if [ $# -eq 2 ]
		then
			echo $all_labels" "$2 > $LABELS_STORAGE_FILE
			echo $all_paths" "$PWD > $PATHS_STORAGE_FILE
		else
			echo $all_labels" "$2 > $LABELS_STORAGE_FILE
			echo $all_paths" "$3 > $PATHS_STORAGE_FILE
		fi
	elif [ $1 = del ]
	then
		local LABELS_STORAGE_FILE=$UT_PATH$LABELS_STORAGE_PATH
		local PATHS_STORAGE_FILE=$UT_PATH$PATHS_STORAGE_PATH

		if [ $2 = all ]
		then
			echo "" > $LABELS_STORAGE_FILE
			echo "" > $PATHS_STORAGE_FILE
		else
			local all_labels=(`cat $LABELS_STORAGE_FILE`)
			local all_paths=(`cat $PATHS_STORAGE_FILE`)

			local new_labels=""
			local new_paths=""
			for i in ${!all_labels[@]}
			do
				if [ ${all_labels[$i]} != $2 ]
				then
					new_labels=$new_labels" "${all_labels[$i]}
					new_paths=$new_paths" "${all_paths[$i]}    
				fi
			done

			echo $new_labels > $LABELS_STORAGE_FILE
			echo $new_paths > $PATHS_STORAGE_FILE
		fi
	elif [ $1 = rename ]
	then
		local LABELS_STORAGE_FILE=$UT_PATH$LABELS_STORAGE_PATH
		local all_labels=(`cat $LABELS_STORAGE_FILE`)

		local new_labels=""
		for label in ${all_labels[@]}
		do
			if [ $label != $2 ]
			then
				new_labels=$new_labels" "$label
			else
				new_labels=$new_labels" "$3
			fi
		done

		echo $new_labels > $LABELS_STORAGE_FILE
	elif [ $1 = labels ]
	then
		local LABELS_STORAGE_FILE=$UT_PATH$LABELS_STORAGE_PATH
		local PATHS_STORAGE_FILE=$UT_PATH$PATHS_STORAGE_PATH

		local all_labels=(`cat $LABELS_STORAGE_FILE`)
		local all_paths=(`cat $PATHS_STORAGE_FILE`)

		for i in ${!all_labels[@]}
		do
			echo ${all_labels[$i]} ${all_paths[$i]}
		done
	else
		local LABELS_STORAGE_FILE=$UT_PATH$LABELS_STORAGE_PATH
		local PATHS_STORAGE_FILE=$UT_PATH$PATHS_STORAGE_PATH

		local all_labels=(`cat $LABELS_STORAGE_FILE`)
		local all_paths=(`cat $PATHS_STORAGE_FILE`)

		for i in ${!all_labels[@]}
		do
			if [ ${all_labels[$i]} = $1 ]
			then
				cd ${all_paths[$i]}
				break  
			fi
		done
	fi
}
