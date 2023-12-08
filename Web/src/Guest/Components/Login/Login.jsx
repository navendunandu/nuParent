
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import './login.css'
import { Button, Stack, TextField, Typography } from '@mui/material';
import { useEffect, useState } from 'react';
import { useNavigate } from "react-router-dom";
import Logo from '../../../assets/nuParent.png'



const Login = () => {


  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('admin')
   const navigate = useNavigate()


  const Check = () => {
    if (email === 'admin@gmail.com' && password === 'admin') {
       navigate('../Admin/')
    }
  }

    useEffect(() => {
      setEmail('admin@gmail.com')
      setPassword('admin')
    }, [])
 
  return (
    <Box
      sx={{
        display: 'flex',
        flexWrap: 'wrap',
        '& > :not(style)': {
          m: 2,
          width: '100%',
          minHeight: '95vh',
        },
      }}
    >

      <Paper elevation={3} sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center', minHeight:'100% ' }}>
        <Box sx={{ width: '50%', m: 2, display:'flex', justifyContent:'center' }} >
         <img src={Logo} width={300}  alt=''/>
        </Box>
        <Box sx={{ width: '50%', m: 2, display: 'flex', justifyContent: 'center' }} >
          <Box>
            <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h4'>Login</Typography>

            <hr />
            <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h7'>Sign in to your account</Typography>



            <Box
              component="form"
              sx={{
                '& > :not(style)': { m: 1, width: '45ch', display: 'flex', justifyContent: 'center' },
              }}
              noValidate
              autoComplete="off"
            >
              <TextField id="outlined-basic" label="Email" variant="outlined" value={'admin@gmail.com'} />
              <TextField id="outlined-basic" label="Password" variant="outlined" value={'admin'} />
              <Stack spacing={2} direction="row">
                <Button variant="contained" sx={{ width: 180, height: 45 }} onClick={Check}>Login</Button>
              </Stack>

            </Box>
          </Box>
        </Box>
      </Paper>
    </Box>
  )
}

export default Login