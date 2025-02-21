#!/bin/bash
#SBATCH --partition=2080ti-short
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB

export TASK=mrpc
export DATA_DIR=./glue_data/MRPC/
export MAX_LENGTH=128
export LEARNING_RATE=2e-5
export BERT_MODEL=bert-base-cased
export BATCH_SIZE=16
export NUM_EPOCHS=10
export SEED=2
export OUTPUT_DIR_NAME=mrpc-pl-bert
export CURRENT_DIR=${PWD}
export OUTPUT_DIR=${CURRENT_DIR}/${OUTPUT_DIR_NAME}

# Make output directory if it doesn't exist
mkdir -p $OUTPUT_DIR
# Add parent directory to python path to access lightning_base.py
export PYTHONPATH="../":"${PYTHONPATH}"

CUDA_VISIBLE_DEVICES=0 python3 run_pl_glue.py --data_dir $DATA_DIR \
--task $TASK \
--model_name_or_path $BERT_MODEL \
--output_dir $OUTPUT_DIR \
--max_seq_length  $MAX_LENGTH \
--learning_rate $LEARNING_RATE \
--max_epochs $NUM_EPOCHS \
--train_batch_size $BATCH_SIZE \
--seed $SEED \
--gpus 1 \
--do_train \
--do_predict
