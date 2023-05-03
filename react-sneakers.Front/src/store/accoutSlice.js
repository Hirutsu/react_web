import { createSlice } from '@reduxjs/toolkit'

const accoutSlice = createSlice({
  name: 'accoutSlice',
  initialState: {
    items: [],
    isSign: false,
    userName: "",
    userRole: "",
  },
  reducers: {
    setIsSign(state, action) {
        state.isSign = action.payload
    },
    setName(state, action) {
        state.userName = action.payload
    },
    setRole(state, action) {
        state.userRole = action.payload
    },
  },
})


export const { setIsSign, setName, setRole } = accoutSlice.actions

export default accoutSlice.reducer