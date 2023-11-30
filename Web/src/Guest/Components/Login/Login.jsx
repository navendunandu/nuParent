import React from 'react'
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';

import './login.css'


const Login = () => {
  return (
    <div className='container d-flex '>
      <div className='w-50 '></div>
      <div className='w-50  d-flex justify-content-center align-items-center min-vh-100'>
        <div className=''>
          <div className='Main-head'>
            <div className='inner-head'>
              Login
            </div>
          </div>
          <div className='d-flex justify-content-center text-danger'>
            Sign into your account
          </div>
          <div className='input-container' >
            <Form.Control type="text" placeholder="Email" className='mt-4 ' />
            <Form.Control type="text" placeholder="Password" className='mt-4' />
          </div>
          <div className='d-flex justify-content-center m-4'>
            <Button variant="danger" className='px-5 py-2'>Login</Button>
          </div>

        </div>

      </div>

    </div>
  )
}

export default Login