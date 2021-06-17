# VC Language Scanner
### Prerequisites

- Install JDK8+
- Install JFlex

### Generate Scanner

1. Run JFlex with<br> 
```jflex Lexical.flex```
2. Compile the generated .java file<br>
```javac Scanner.java```

### Run Scanner

1. Scan a single file<br>
```java Scanner <test_file_name>``` 

2. Scan multiple files
  - Copy all files to folder ```input\``` 
  - Run script ```run_test.ps1``` in powershell<br>
   ```.\scan-multiple.ps1```
  - Result of each file will be generated in the ```output\``` folder
