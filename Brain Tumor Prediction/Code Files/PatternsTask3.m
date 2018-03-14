%IMPORTING TRAINING SET IMAGES
[Normal_Images_Training, Normal_Labels] = ReadImageFn('C:\Users\Dell\Desktop\Pattern Task 3\train-20171102T075247Z-001\normal', 1);
[Cancer_Images_Training, Cancer_Labels] = ReadImageFn('C:\Users\Dell\Desktop\Pattern Task 3\train-20171102T075247Z-001\tumor', 2);
[row1 , Normal_Number] = size(Normal_Images_Training);
[row2 , Cancer_Number] = size(Cancer_Images_Training);

%IMPORTING TESTING SET IMAGES
[Normal_Images_Testing, Normal_Labels_Test] = ReadImageFn('C:\Users\Dell\Desktop\Pattern Task 3\test-20171102T075549Z-001\normal', 1);
[Cancer_Images_Testing, Cancer_Labels_Test] = ReadImageFn('C:\Users\Dell\Desktop\Pattern Task 3\test-20171102T075549Z-001\tumor', 2);
[row3 , Normal_Number_Test] = size(Normal_Images_Testing);
[row4 , Cancer_Number_Test] = size(Cancer_Images_Testing);

%IMPORTING TESTING SET EXTENDED IMAGES
[Test_Extended, Test_Extended_Labels] = ReadImageFn('C:\Users\Dell\Desktop\Pattern Task 3\newtest-20171102T075315Z-001\newtest', 1);
[row5 , Test_Extended_Number] = size(Test_Extended);

Test_Number = Normal_Number_Test + Cancer_Number_Test;
Actual_Labels = [transpose(Normal_Labels_Test); transpose(Cancer_Labels_Test)];

%TRAINING SET FEATURE EXTRACTION
Training_Features_Extracted = FeatureExtractionMethod(Normal_Number, Cancer_Number, Normal_Images_Training, Cancer_Images_Training);
[Training_Features_Extracted_Normal, Training_Features_Extracted_Cancer] = SplitFn(Training_Features_Extracted, Normal_Number, Cancer_Number);

%TEST SET FEATURE EXTRACTION
Testing_Features_Extracted = FeatureExtractionMethod(Normal_Number_Test, Cancer_Number_Test, Normal_Images_Testing, Cancer_Images_Testing);

%TEST SET FEATURE EXTRACTION EXTENDED
Testing_Features_Extracted_Extended = FeatureExtractionMethod(Test_Extended_Number, Test_Extended_Number, Test_Extended, Test_Extended);

%BASIAN CLASSIFIER CALL
Confusion_Matrix = Naive_Basyian_Classification(Training_Features_Extracted_Normal, Training_Features_Extracted_Cancer, Normal_Number, Cancer_Number, Testing_Features_Extracted, Test_Number, Actual_Labels);

%ACCURACY VALUE
Accuracy = AccuracyFn(Confusion_Matrix, Test_Number);

%TEST NEW INPUT
prompt = 'Do You Want to Enter New Test?! Y/N:  ';
Question = input(prompt, 's');
if(Question == 'Y')
    for i = 1: 100
        Image_Number = 'Enter Image Number!! In Range[1- 20.JPG], [2- 27.JPG], [3- 30.JPG], [4- 7.JPG], [5- 8.JPG]: ';
        idx = input(Image_Number);
        if(idx > 5)
            disp('Please Enter Correct Number!!');
            Image_Number = 'Enter Image Number!! In Range[1- 20.JPG], [2- 27.JPG], [3- 30.JPG], [4- 7.JPG], [5- 8.JPG]: ';
            idx = input(Image_Number);
        end
        Label = Naive_Basyian_Classification_Modified(Training_Features_Extracted_Normal, Training_Features_Extracted_Cancer, Normal_Number, Cancer_Number, Testing_Features_Extracted_Extended(idx, :), 1);
        disp('The Label is: ');
        if(Label == 1)
            disp('Normal Class');
        else
             disp('Cancer Class')
        end
        % imshow(Test_Extended{idx});
        Request = 'Do You Want to Enter New Image?!! Y/N: ';
        ans = input(Request, 's');
        if(ans == 'N')
            break;
        end
    end
end







