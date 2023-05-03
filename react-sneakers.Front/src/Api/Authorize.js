import axios from "axios";

export default class Authorize {
    static async authorize(account){
        const response = await axios.post(`https://localhost:7217/api/Account/Login`, account);
        return response;
    }   
}