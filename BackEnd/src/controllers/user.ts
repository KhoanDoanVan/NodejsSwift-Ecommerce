import { Request, Response } from "express"
import { validateEmail, validateLength } from "../utils/validation"
import bcrypt from 'bcrypt'
import User from "../models/user"

// Register
export const register = async(req: Request, res: Response): Promise<void> => {
    try {
        const {name, email, password} = req.body

        if (!(validateEmail(email))) {
            res.status(400).json({
                message: "Invalid Email Address"
            })
            return
        }

        const existingEmail = await User.findOne({email})

        if (existingEmail) {
            res.status(400).json({
                message: "Email Already Exists"
            })
        }

        const existingName = await User.findOne({name})

        if (existingName) {
            res.status(400).json({
                message: "Name Already Exists"
            })
            return
        }

        if (validateLength(name, 4, 25)) {
            res.status(400).json({
                message: "Name must be larger 4 characters and lesser 25 characters"
            })
            return
        }

        const hashedPassword = await bcrypt.hash(password, 12)

        const user = new User({
            name: name,
            email: email,
            password: hashedPassword
        })

        await user.save()

        res.status(200).json({
            message: "Register Successfully. Please activate Email to Proceed."
        })

        return

    } catch(error) {
        const statusCode = (error as any).statusCode || 500
        const message = (error as any).message || "Server Error"

        res.status(statusCode).send({message})
        
        return
    }
}