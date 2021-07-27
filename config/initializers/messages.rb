module Messages
    
    #messages for login validations
    EMAIL_AND_PASSWORD_REQUIRE_VALIDATION = "Both Email and Password are required"
    EMAIL_REQUIRE_VALIDATION = "Email is required"
    PASSWORD_REQUIRE_VALIDATION = "Password is required"
    INVALID_EMAIL_OR_PASSWORD = "Email or password is invalid"

    # message for password change
    PASSWORD_AND_CONFIRM_PASSWORD_REQUIRED = "Both Password and Confirm Password are required."
    PASSWORD_CONFIRMATION_REQUIRED = "Password Confirm Password is required."
    PASSWORD_AND_CONFIRM_PASSWORD_NOT_THE_SAME = "Password and Confirm Password must be the same."

    #csv
    REQUIRE_FILE_VALIDATION = "Please select a file"  
    INCORRECT_HEADER_VALIDATION = "The Header is incorrect"
    UPLOAD_SUCCESSFUL = "CSV file is uploaded successfully"
    WRONG_HEADER = "The header is wrong"
    WRONG_COLUMN = "The Column is wrong"
    WRONG_FILE_TYPE = "Please select CSV file"
end