import mongoose, { Schema, Model } from 'mongoose'
const {ObjectId} = mongoose.Schema


interface ICode extends Document {
  code: String
  user: mongoose.Types.ObjectId
}

const codeSchema: Schema = new Schema({
  code: {
    type: String,
    required: true
  },
  user: {
    type: ObjectId,
    ref: "User",
    required: true
  }
})

export default mongoose.model<ICode>("Code", codeSchema)