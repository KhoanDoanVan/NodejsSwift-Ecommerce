
import dotenv from 'dotenv'
import { OAuth2Client } from 'google-auth-library'
import { SendMailOptions, TransportOptions, Transporter, createTransport } from 'nodemailer'

dotenv.config()

const OAUTH_PLAYGROUND = 'https://developers.google.com/....'

const {EMAIL, MAILING_ID, MAILING_REFRESH, MAILING_SECRET} = process.env

if (!EMAIL || !MAILING_ID || !MAILING_REFRESH || !MAILING_SECRET) {
  throw new Error("Missing Required Environment variables")
}

const auth = new OAuth2Client(MAILING_ID, MAILING_SECRET, OAUTH_PLAYGROUND)
auth.setCredentials({
  refresh_token: MAILING_REFRESH
})

export const sendVerificationEmail = async (email: String, name: String, code: String): Promise<void> => {
  try {
    const accessToken = await auth.getAccessToken()

    if(!accessToken) {
      throw new Error("Failed to get access token")
    }

    const transporter: Transporter = createTransport({
      service: 'gmail',
      auth: {
        type: "OAUTH2",
        user: EMAIL,
        clientId: MAILING_ID,
        clientSecret: MAILING_SECRET,
        refreshToken: MAILING_REFRESH,
        accessToken: accessToken.token
      }
    } as TransportOptions)

    const mailOptions: SendMailOptions = {
      from: EMAIL,
      to: EMAIL,
      subject: "Verify Your Email",
      html: `
      <h1> Email Confirmation </h1>
      <h2> Hello ${name} </h2>
      <p>
      Thank you for joining iStore. Please confirm your email, with the following code.

      </p>
      <h3>
      ${code}
      </h3>

      <p>
      If you did not request this service. Ignore this email.

      </p>
      `
    }

    const result = await transporter.sendMail(mailOptions)
    console.log("Email sent", result)

  } catch (error: any) {
    if (error.response && error.response.data && error.response.data.error == 'invalid_grant') {
       console.error("Access token expired or revoked. Refreshing Token")

       try {
        const tokens = await auth.refreshAccessToken()
        auth.setCredentials(tokens.credentials)
        await sendVerificationEmail(email, name, code)
       } catch(refreshError) {
        console.error("Error refreshing Access Token", refreshError)
       }
    } else {
      console.error("Error sending email", error)
    }
  }
}

