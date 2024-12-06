MODEL_PATH=$1
MODEL_BASE=$2
OUTPUT_DIR=$3
TASKNAME=$4
DATA_DIR=$5
FRAMES_PATH=$6
AWQ=$7
AWQ_PATH=$8
AWQ_w_bit=$9
AWQ_q_group_size=${10}

AWQ_FLAG=""
if [ "$AWQ" == "true" ]; then
  AWQ_FLAG="--awq"
fi

AWQ_PATH_FLAG=""
if [ -n "$AWQ_PATH" ]; then
  AWQ_PATH_FLAG="--awq_path $AWQ_PATH"
fi

AWQ_w_bit_FLAG=""
if [ -n "$AWQ_w_bit" ]; then
  AWQ_w_bit_FLAG="--w_bit $AWQ_w_bit"
fi

AWQ_q_group_size_FLAG=""
if [ -n "$AWQ_q_group_size" ]; then
  AWQ_q_group_size_FLAG="--q_group_size $AWQ_q_group_size"
fi

bash Evaluation/videochatgpt/scripts/infer_general.sh \
    $MODEL_PATH \
    $MODEL_BASE \
    $OUTPUT_DIR \
    $TASKNAME \
    $DATA_DIR \
    $FRAMES_PATH \
    $AWQ_FLAG \
    "$AWQ_PATH_FLAG" \
    "$AWQ_w_bit_FLAG" \
    "$AWQ_q_group_size_FLAG"
wait
