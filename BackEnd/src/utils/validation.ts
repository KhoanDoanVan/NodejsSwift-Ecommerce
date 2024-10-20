export const validateEmail = (email: String): boolean => {

    return !!String(email)
    .toLowerCase()
    .match(/^([a-z\d\.-]+)@([a-z\d-]+)\.([a-z]{2,12})(\.[a-z]{2,12})?$/)
}

export const validateLength = (text: String, min: number, max: number): boolean => {
    return !(text.length > max || text.length < min)
}