# Đọc dữ liệu từ file txt
with open(r"C:\Users\luan1\OneDrive\Desktop\TKS\Lab\Lab4\Code\conf.txt", "r") as file:
    lines = file.readlines()

# Thêm '16'h' vào đầu mỗi dòng và kết thúc mỗi dòng bằng dấu phẩy, trừ dòng cuối
formatted_lines = [f"8'b{line.strip()}," if line != lines[-1] else f"8'b{line.strip()}" for line in lines]

# Ghi kết quả vào file mới
with open("convert_conf.txt", "w") as file:
    file.write("\n".join(formatted_lines))
