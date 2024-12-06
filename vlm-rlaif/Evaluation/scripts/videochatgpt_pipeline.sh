NEW_PYPTH=$PWD/../..
NEW_PYPTH=$(builtin cd $NEW_PYPTH; pwd)
export PYTHONPATH=$PYTHONPATH:$NEW_PYPTH

# AWQ Option
AWQ=${1:-false}  # false or true
AWQ_PATH=${2:-"../llm-awq/quant_cache/vlm_rlaif_video_llava_7b-w4-g128-awq-v2.pt"}  # path to the AWQ model
AWQ_w_bit=${3:-"4"}  # bit for AWQ
AWQ_q_group_size=${4:-"128"}  # group size for AWQ

# ================== CHANGE HERE ==================
# MODEL_PATH=SNUMPR/vlm_rlaif_video_llava_7b
MODEL_PATH=SNUMPR/vlm_rlaif_video_llava_7b
MODEL_BASE=none
OUTPUT_DIR=results/vlm_rlaif_video_llava_7b_time
export cache_dir=./cache_dir
export API_KEY=""

TASKNAMES=( temporal ) # generic / consistency / temporal
DATA_DIR=SNUMPR/VCG-bench/orginal_data
FRAMES_PATH=SNUMPR/VCG-bench/videochatgpt_anet_50frames
# ================== CHANGE HERE ==================
OUTPUT_DIR=$OUTPUT_DIR/videochatgpt

for TASKNAME in ${TASKNAMES[@]}; do
    bash Evaluation/videochatgpt/scripts/pipeline_$TASKNAME.sh \
        $MODEL_PATH \
        $MODEL_BASE \
        $OUTPUT_DIR \
        $TASKNAME \
        $DATA_DIR \
        $FRAMES_PATH \
        $AWQ \
        $AWQ_PATH \
        $AWQ_w_bit \
        $AWQ_q_group_size
    wait
done