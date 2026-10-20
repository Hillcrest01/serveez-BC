query 50107 "SD Portal Account Query"
{
    Caption = 'Serveez Portal Accounts';

    elements
    {
        dataitem(Serveez_Portal_Users; "Serveez Portal Users")
        {
            column(UserID; "User ID")
            {
            }

            column(CustomerNo; "Customer No.")
            {
            }

            column(Email; Email)
            {
            }
            column(Password_Hash; "Password Hash")
            {

            }

            column(Phone; Phone)
            {
            }

            column(Active; Active)
            {
            }

            column(EmailVerified; "Email Verified")
            {
            }
            column(Email_Verification_Token; "Email Verification Token")
            {

            }

            column(LastLogin; "Last Login")
            {
            }

            column(CreatedAt; "Created At")
            {
            }
        }
    }
}