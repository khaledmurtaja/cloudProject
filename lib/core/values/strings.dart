const emailIsRequiredMessage="Email is required.";
const wrongEmailFormatMessage="Invalid email format.";
const passwordIsRequiredMessage="Password is required.";
const detailsIsRequiredMessage="حقل التفاصيل مطلوب";
const atLeast10CharForDetailsFieldMessage="يجب ان يحتوي هذا الحقل 10 حروف على الاقل";
const lessThan8charMessage="Password must have at least 8 characters.";
const atLeast1UpperCaseLetterMessage="Password must contain at least one upper case character";
const atLeast1LowerCaseLetterMessage="Password must contain at least one lower case character";
const atLeast1NumberMessage="Password must contain at least one number.";
const atLeast1SpecialCharacterMessage="Password must contain at least one special character(\$%^&())_ .";
const nameIsRequiredMessage="Name is required.";
const courseNameIsRequiredMessage="Course name is required.";
const unMatchedPasswordsMessage="كلمتا المرورر غير متوافقتين";
const nameMustHave4LettersAtLeastMessage="name must have at least 4 characters.";
const courseNameMustHave4LettersAtLeastMessage="Course name must have at least 4 characters.";

const nameMustHave30LettersAtMostMessage="30 characters maximum";
const lessThat200CharRequiredMessage="description exceeded 3000 characters";
const phoneNumberRequiredMessage="رقم الهاتف مطلوب" ;
const unValidPhoneNumMessage="رقم الهاتف غير صالح" ;
const unValidIdNumber="يبدأ رقم الهوية ب 0او 9 او 4 او 8, ويجب ان يتكون من 9 أرقام";
const idIsRequiredMessage="Id is required";
const whiteSpacesError="ID can't have white spaces.";
final RegExp uppercaseRegex = RegExp(r'[A-Z]');
final RegExp lowercaseRegex = RegExp(r'[a-z]');
final RegExp numberRegex = RegExp(r'[0-9]');
final RegExp specialCharRegex = RegExp(r'[!@#\$%\^&\*\(\)_\+<>\?/\|\\~\[\]\{\}]');
final RegExp phoneNumberRegex = RegExp(r'^(059|056)\d{7}$');
final RegExp idNumberRegex = RegExp(r'(9|8|0|4)\d{8}');
final RegExp whiteSpaceRegex = RegExp(r'^\S*$');
const String landingPageKey="isLandingPageSkipped";
const String loginPageKey="isLoggedIn";


