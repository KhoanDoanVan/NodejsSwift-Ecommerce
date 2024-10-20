import express from 'express'
import dotenv from 'dotenv'
import mongoose from 'mongoose'
import cors from 'cors'
import userRouter from './src/routes/user'

dotenv.config()

const app = express()
const PORT = process.env.PORT || 4000
const MONGO_URI = process.env.DATABASE_URL

if (!MONGO_URI) {
    throw new Error("Database_URI is not defined in environment variables")
}

mongoose.connect(MONGO_URI)
.then(() => {
    console.log("MongoDB connected")
})
.catch(error => console.log("MongoDB connection failed: ", error))

app.use(cors())
app.use(express.json())

app.use(userRouter)

app.get('/', (req, res) => {
    res.send('Hello world from server 2')
})

app.listen(PORT, () => {
    console.log(`Server running on ${PORT}`)
})