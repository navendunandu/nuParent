import React from 'react'
import { Route, Routes } from 'react-router-dom'
import Admin from './Admin/App'
import Guest from './Guest/App'
import 'bootstrap/dist/css/bootstrap.min.css';



const App = () => {
  return (
  <Routes>
    <Route path='/' element={<Guest/>} />
    <Route path='/Admin' element={<Admin/>} />
  </Routes>
  )
}

export default App