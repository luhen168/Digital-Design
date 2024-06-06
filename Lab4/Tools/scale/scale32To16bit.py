def scale_signed_32_to_signed_16(input_file, output_file):
    # Đọc dữ liệu từ tệp txt
    with open(input_file, 'r') as f:
        lines = f.readlines()

    # Tìm giá trị lớn nhất và nhỏ nhất trong dữ liệu 32-bit
    max_value_32 = 2**31 - 1
    min_value_32 = -2**31

    # Tìm giá trị lớn nhất và nhỏ nhất trong dữ liệu 16-bit
    max_value_16 = 2**15 - 1
    min_value_16 = -2**15

    # Tạo một tệp mới để lưu dữ liệu 16-bit
    with open(output_file, 'w') as f:
        # Scale dữ liệu từ 32-bit sang 16-bit
        for line in lines:
            # Kiểm tra nếu dòng có chứa ký tự 'x' thì bỏ qua
            if 'x' in line:
                continue
            # Loại bỏ khoảng trắng từ dòng và kiểm tra nếu dòng không rỗng
            line = line.strip()
            if line:
                # Chuyển đổi dòng từ dạng chuỗi sang một số nguyên 32-bit
                value_32 = int(line, 2)

                # Scale giá trị
                scaled_value = int((value_32 - min_value_32) * (max_value_16 - min_value_16) / (max_value_32 - min_value_32) + min_value_16)

                # Ghi giá trị đã scale vào tệp mới
                f.write(format(scaled_value, '016b') + '\n')

# Gọi hàm để chuyển đổi dữ liệu từ 32-bit sang 16-bit
scale_signed_32_to_signed_16(r'C:\Users\luan1\OneDrive\Desktop\TKS\Lab\Lab4\Testbench\output32bit.txt', 'output16bit.txt')
