#!/bin/bash

# Dừng lại nếu có lỗi xảy ra
set -e

echo "========================================="
echo "  SCRIPT CAI DAT TU DONG BOT AOYAMA"
echo "========================================="

# Cập nhật và cài đặt các gói hệ thống cần thiết
echo "[1/5] Dang cap nhat va cai dat cac cong cu he thong..."
pkg update -y && pkg upgrade -y
pkg install git python ffmpeg -y

# Clone code từ GitHub
# THAY THẾ LINK GITHUB CỦA BẠN VÀO ĐÂY
REPO_URL="https://github.com/Vyfuy/aoyama-bot-mobile.git" 
# Lấy tên thư mục từ link repo
REPO_NAME=$(basename "$REPO_URL" .git) 

echo "[2/5] Dang tai code bot tu GitHub..."
# Xóa thư mục cũ nếu đã tồn tại để đảm bảo code mới nhất
if [ -d "$REPO_NAME" ]; then
  rm -rf "$REPO_NAME"
fi
git clone "$REPO_URL"
cd "$REPO_NAME"

# Cài đặt các thư viện Python
echo "[3/5] Dang cai dat cac thu vien Python..."
pip install -r requirements.txt

# Tạo file .env và hỏi người dùng nhập token
echo "[4/5] Thiet lap cac API Key..."
# Xóa file .env cũ nếu có
if [ -f ".env" ]; then
  rm ".env"
fi

# Hàm để hỏi và ghi vào file .env
prompt_and_write() {
  read -p "-> Vui long nhap gia tri cho $1: " value
  echo "$1=$value" >> .env
}

prompt_and_write "DISCORD_TOKEN"
prompt_and_write "YOUTUBE_API_KEY"
prompt_and_write "HUGGINGFACE_API_TOKEN"
prompt_and_write "NEWS_API_KEY"
prompt_and_write "STABILITY_API_KEY"
prompt_and_write "OPENWEATHER_API_KEY"
# Thêm các key khác nếu bạn có

echo "Da tao file .env thanh cong!"

# Chạy bot
echo "[5/5] Khoi dong bot..."
echo "========================================="
echo "QUA TRINH CAI DAT HOAN TAT!"
echo "Bot cua ban dang khoi dong..."
echo "De bot chay ngam, hay chay lai bang: screen -S aoyama python3 main.py"
echo "========================================="

python3 main.py
