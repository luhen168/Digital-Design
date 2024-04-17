

# SPEC
```
Thiết kế bộ cân bằng âm thanh. 
Chi tiết về bộ Equalizer: Audio equalizer based on FIR filters. | controlpaths.com

Đầu vào: Âm thanh được lấy mẫu với tần số 16Khz, độ rộng bit là 16 bit.
Đầu vào: 8 hệ số khuếch đại cho 8 băng tần số cần cân bằng
Đầu ra: Tín hiệu âm thanh ra. 
Kết quả cần báo cáo:
Độ trễ từ đầu vào đến đầu ra. 
Số cell FPGA cần sử dụng. 
Cách mô phỏng chứng minh mạch hoạt động đúng
Dùng python đọc file wav, vẽ đồ thị phổ của file wav
Tạo file đầu vào là file text với mỗi hàng là 1 mẫu âm thanh lưu là 1 số HEX 16 bit
Testbench đọc file text âm thanh đầu vào vào mảng bộ nhớ 16bit và đưa vào mạch. 
Testbench lấy đầu ra của mạch và lưu vào file text output.txt mỗi hàng 1 là giá trị mẫu âm thanh 
Dùng python đọc file output.txt và chuyển thành file wav, vẽ đồ thị phổ
Dùng python tạo file outout_python.txt bằng cách dùng các hàm của python để tạo ra bộ Equalizer. So sánh kết quả output.txt với file output_python.txt
Tổng hợp mạch bằng FPGA báo cáo các resource cần sử dụng: số cell logic, số LUT, số DSP, số RAM
```

## 1. Mô tả thiết kế 


## 2. Cách bố trí code


## 3. Cách test, kiến trúc testbench
### 3.1. Cách test
B1: Chuyển file wav lấy mẫu 16khz sang txt mỗi dòng 16bit. (nếu file wav chưa 16khz thì convert qua link này <a href="https://g711.org">g711.org</a> )

B2: Chạy file <a href="Testbench\tb_equalizer_8band.v"> testbench sẽ đọc file input từ 1 file wav 16khz mà bạn muốn trong thư mục <a href="Tools\wav convert\wav original"> và lưu lại kết quả vào các file đầu ra xuất hiện trong thư mục <a href="Testbench">

B3: Vào thư mục <a href="Tools\scale"> để scale các file đầu ra của B1 về 16bits
Sau đó đem chuyển thành file wav bằng <a href="Tools\wav convert\wav convert.py">

B4: Đem đi vẽ phổ và so sánh với output_python.txt( nhưng chưa làm được python equalizer).


## 4. Kết quả tổng hợp trên kit 


## 5. Mô phỏng

to be continue....

