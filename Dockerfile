# USE_LOCAL=on USE_GPU=off sh start_docker.sh
# USE_LOCAL=off USE_GPU=off sh start_docker.sh
FROM python:3.10

WORKDIR /app
RUN pip install faiss-cpu fairseq pyngrok && pip install pyworld --no-build-isolation
COPY server/requirements.txt requirements.txt
RUN pip install -r requirements.txt
RUN apt-get update && apt-get -y install libportaudio2 -qq

RUN apt-get update \
    && apt-get install espeak gosu -y \
    && apt-get clean

COPY . /voice-changer
WORKDIR /voice-changer/server
# CMD ["MMVCServerSIO.py", \
#   "-p", "8000", \
#   "--https", "False", \
#   "--content_vec_500", "pretrain/checkpoint_best_legacy_500.pt", \
#   "--content_vec_500_onnx", "pretrain/content_vec_500.onnx", \
#   "--content_vec_500_onnx_on", "true", \
#   "--hubert_base", "pretrain/hubert_base.pt", \
#   "--hubert_base_jp", "pretrain/rinna_hubert_base_jp.pt", \
#   "--hubert_soft", "pretrain/hubert/hubert-soft-0d54a1f4.pt", \
#   "--nsf_hifigan", "pretrain/nsf_hifigan/model", \
#   "--crepe_onnx_full", "pretrain/crepe_onnx_full.onnx", \
#   "--crepe_onnx_tiny", "pretrain/crepe_onnx_tiny.onnx", \
#   "--rmvpe", "pretrain/rmvpe.pt", \
#   "--model_dir", "model_dir", \
#   "--samples", "samples.json", \
#   "--use_gpu", "False"]

#   docker run -it -p 9931:9931 -v ../data/voice_changer_dir:/voice-changer/model_dir voice-changer
# docker run -it -p 8000:8000 -v $(pwd)/../data/voice_changer_models:/voice-changer/server/model_dir voice-changer

# RUN chmod 0777 /voice-changer/server/MMVC_Client
RUN chmod 0777 /voice-changer/server

ADD docker/setup.sh  /voice-changer/server
ADD docker/exec.sh  /voice-changer/server


WORKDIR /voice-changer/server
# ENTRYPOINT ["/bin/bash", "setup.sh"]
# CMD [ "-h"]
