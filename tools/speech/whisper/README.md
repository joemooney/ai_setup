sudo apt update
sudo apt install ffmpeg python3 python3-venv python3-pip
python3 -m venv whisper-env
source whisper-env/bin/activate
pip install -U openai-whisper
pip install pyaudio gradio

