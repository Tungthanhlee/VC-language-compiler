# VC Language Scanner

### Các thành viên trong nhóm:
- Lê Văn Thịnh 
- Lê Thanh Tùng
- Bùi Văn Phúc

### Yêu cầu
- Java JDK8+
- jflex
### Cách chạy chương trình
#### Option 1:
1. Compile file Lexical.flex
```jflex Lexical.flex```

2. Xóa nội dung cũ trong file output/output.txt

3. Compile file Scanner.java
```javac Scanner.java```

4. Chạy file code vc<br>
```java Scanner <test_file_name>``` 
```ex: java Scanner input/input.vc```

#### Option 2: Chạy file bash
Có thể chạy file ```run_scanner.sh``` để chạy toàn bộ 4 bước trên và kết quả được in ra file ```output/output.txt```

### Hệ điều hành
Ubuntu 18.04
MacOS
