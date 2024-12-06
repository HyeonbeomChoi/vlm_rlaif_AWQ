from huggingface_hub import snapshot_download
import tarfile

snapshot_download('SNUMPR/vlm_rlaif_video_llava_7b', local_dir='SNUMPR/vlm_rlaif_video_llava_7b', local_dir_use_symlinks=True)
snapshot_downlaoad('SNUMPR/VCG-bench', local_dir='SNUMPR/VCG-bench', local_dir_use_symlinks=True)

tar_path = './SNUMPR/VCG-bench/videochatgpt_anet_50frames.tar'
extract_path = './SNUMPR/VCG-bench/'

with tarfile.open(tar_path, 'r') as tar:
    tar.extractall(path=extract_path)
    print(f"Extracted {tar_path} to {extract_path}")