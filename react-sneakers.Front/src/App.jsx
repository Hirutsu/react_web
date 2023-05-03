import React, { useState } from "react";
import Header from "./components/Header";
import Main from "./components/Main";
import Cart from "./components/Cart";
import Favorites from "./components/Favorites";
import "./main.scss";
import { Routes, Route } from "react-router-dom";
import NotFoundPage from "./components/NotFoundPage";
import Orders from "./components/Orders";
import Admin from "./components/Admin";
import LogIn from "./components/LogIn";

const App = () => {
  return (
    <div className="layout">
      <Cart />
      <div className="main-content">
        <Header />
        <Routes>
          <Route path="/" element={<Main />} />
          <Route path="/favorites" element={<Favorites />} />
          <Route path="/orders" element={<Orders />} />
          <Route path="/admin" element={<Admin />} />
          <Route path="/logIn" element={<LogIn />} />
          <Route path="*" element={<NotFoundPage />} />
        </Routes>
      </div>
    </div>
  );
};

export default App;
