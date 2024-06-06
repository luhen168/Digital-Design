

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
Bài tập được thực hiện bởi nhóm 9
Nhóm 9
Thành viên: Lê Văn Quân
            Lê Thành Luân
            Trần Quang Huy
            Phạm Trương Hà Phương
Giảng viên: Thầy Nguyễn Đức Minh
Mentor: Anh Lâm và Anh Chuyên (Infineon)
        Anh Trần Trung Hiếu
                              
## 1. Mô tả thiết kế 


## 2. Cách bố trí code


## 3. Cách test, kiến trúc testbench
### 3.1. Cách test
B1: Chuyển file wav lấy mẫu 16khz sang txt mỗi dòng 16bit sử dụng <a href="Tools\wav convert\wav convert.py">wav convert.py</a> . (nếu file wav chưa 16khz thì convert qua link này <a href="https://g711.org">g711.org</a> )

B2: Chạy file <a href="Testbench\tb_equalizer_8band.v">tb_equalizer_8band.v</a> testbench sẽ đọc file input từ file txt mà bạn muốn trong thư mục <a href="Tools\wav convert">mono-synth.txt</a> và lưu lại kết quả vào các file đầu ra xuất hiện trong thư mục <a href="Testbench">Testbench</a>

B3: Chạy file <a href="Tools\scale\scale32To16bit.py">scale32To16bit.py</a> để scale các file đầu ra của B1 về 16bits
Sau đó đem chuyển thành file wav bằng <a href="Tools\wav convert\wav convert.py">wav convert.py</a>

B4: Vẽ phổ cho file wav mới <a href="Tools\wav convert\equalizer_ouput.wav">equalizer_ouput.wav</a> được tạo ra từ code Verilog và so sánh với output_python.txt( nhưng chưa làm được python equalizer).


## 4. Kết quả tổng hợp trên kit 


## 5. Mô phỏng

to be continue....


