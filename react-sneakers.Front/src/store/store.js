import { configureStore, combineReducers } from '@reduxjs/toolkit'
import cartStatusSlice from './cartStatusSlice'
import cartItemsSlice from './cartItemsSlice'
import favoritesSlice from './favoritesSlice'
import ordersSlice from './ordersSlice'
import accoutSlice from './accoutSlice'

const rootReducer = combineReducers({
  cartStatus: cartStatusSlice,
  cartItems: cartItemsSlice,
  favoriteItems: favoritesSlice,
  orders: ordersSlice,
  account: accoutSlice
})

export default configureStore({ reducer: rootReducer })
