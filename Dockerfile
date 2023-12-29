FROM  ubuntu:latest

# RUNコマンドは、コンテナ作成時に自動で実行するコマンドを指定
RUN apt update -y
RUN apt install -y sudo git make curl ssh vim bash-completion
# sampleというユーザを作成、P@ssw0rdというPWを設定
RUN useradd -m -s /bin/bash sample
RUN echo "sample:P@ssw0rd" | chpasswd
# sudoでroot権限のコマンドを実行できるように指定
RUN gpasswd -a sample sudo

# コンテナを指定したユーザで実行（rootユーザ以外で実行したい）
USER sample


# ワークディレクトリを設定
WORKDIR /home/sample/
