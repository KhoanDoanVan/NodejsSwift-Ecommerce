import mongoose, { Schema, Model } from 'mongoose'
const {ObjectId} = mongoose.Schema

interface IUser extends Document {
    name: String
    email: String
    password: String
    verified: boolean
    isAdmin: boolean
    stripeCustomerId?: string
}

const userSchema: Schema = new Schema({
    name: {
        type: String, required: true, unique: true, minLength: 4
    },
    email: {
        type: String, required: true, unique: true
    },
    password: {
        type: String, required: true, unique: true, minLength: 4
    },
    verified: {
        type: Boolean, default: false
    },
    isAdmin: {
        type: Boolean, default: false
    },
    stripeCustomerId: {
        type: String
    }
}, {
    timestamps: true
})

const User: Model<IUser> = mongoose.model<IUser>("User", userSchema)

export default User