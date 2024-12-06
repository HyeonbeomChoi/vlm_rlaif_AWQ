NEW_PYPTH=$PWD/../..
NEW_PYPTH=$(builtin cd $NEW_PYPTH; pwd)
export PYTHONPATH=$PYTHONPATH:$NEW_PYPTH

MODEL_PATH=$1
MODEL_BASE=$2
OUTPUT_DIR=$3
TASKNAME=${4:-consistency}
VIDEOCHATGPT_EVAL_PATH=$5
FRAMES_PATH=$6
OUTPUT_DIR=$OUTPUT_DIR/$TASKNAME
AWQ=$7
AWQ_PATH=$8
AWQ_w_bit=$9
AWQ_q_group_size=${10}

GPU_IDS=( 0 1 2 3 4 5 6 7 )
SPLITS=( 0 1 2 3 4 5 6 7 )
GPU_IDS=( 0 )
SPLITS=( 0 0 0 0 0 0 0 0 )
N_SPLIT=${#GPU_IDS[@]}

echo "AWQ: $AWQ"
echo "AWQ_PATH: $AWQ_PATH"
echo "AWQ_w_bit: $AWQ_w_bit"
echo "AWQ_q_group_size: $AWQ_q_group_size"

for DEVICE_ID in ${GPU_IDS[@]}; do
    CUDA_VISIBLE_DEVICES=$DEVICE_ID \
    python3 Evaluation/videochatgpt/infer_consistency.py \
    --model-path $MODEL_PATH \
    --model-base $MODEL_BASE \
    --frames_path $FRAMES_PATH \
    --gt_file $VIDEOCHATGPT_EVAL_PATH/$TASKNAME"_qa.json" \
    --output_dir $OUTPUT_DIR \
    --output_name $N_SPLIT"_${SPLITS[$DEVICE_ID]}" \
    --images \
    --num_frames 50 \
    --rlhf_ckpt \
    --chunks $N_SPLIT \
    --chunk_idx ${SPLITS[$DEVICE_ID]} \
    --resume \
    $AWQ \
    $AWQ_PATH \
    $AWQ_w_bit \
    $AWQ_q_group_size \
    # &
done
wait