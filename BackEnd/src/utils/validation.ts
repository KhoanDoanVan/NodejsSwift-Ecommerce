export const validateEmail = (email: String): boolean => {

    return !!String(email)
    .toLowerCase()
    .match(/^([a-z\d\.-]+)@([a-z\d-]+)\.([a-z]{2,12})(\.[a-z]{2,12})?$/)
}

export const validateLength = (text: String, min: number, max: number): boolean => {
    return (text.length > min && text.length > max)
}

export const generateCode = (length: number): string => {
    let code = ""
    const schema = "0123456789"

    for (let i=0; i < length; i++) {
        code += schema.charAt(Math.floor(Math.random() * schema.length))
    }

    return code
}