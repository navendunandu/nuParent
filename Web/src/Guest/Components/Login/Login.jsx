import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import './login.css'
import { Button, Stack, TextField, Typography } from '@mui/material';
import { useEffect, useState } from 'react';
import { useNavigate } from "react-router-dom";
import Logo from '../../../assets/nuParent.png'
import { db } from '../../../config/firebase';
import { collection, getDocs } from 'firebase/firestore';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [data, setData] = useState('');
  const navigate = useNavigate();

  const Check = (event) => {
    event.preventDefault(); // Prevent the default form submission
    if (email === data.email && password === data.password) {
      navigate('../Admin/');
    } else {
      alert('Invalid email or password. Please check your credentials and try again.');
    }
  };

  const loadAdminDatas = async () => {
    try {
      const querySnapshot = await getDocs(collection(db, "admin"));
      const adminDatas = querySnapshot.docs.map((doc, index) => ({ id: doc.id, index: index + 1, ...doc.data() }));
      setData(adminDatas[0]);
    } catch (error) {
      console.error('Error getting documents: ', error);
    }
  };

  useEffect(() => {
    loadAdminDatas();
  }, []);

  return (
    <>
      <Box className="BoxContainer">
        <Paper elevation={0} className="PaperContainer">
          <Box sx={{ width: '500px', m: 2, display: 'flex', justifyContent: 'center' }} className="smallBox">
            <img src={Logo} width={300} alt='' />
          </Box>
          <Box sx={{ width: '500px', m: 2, display: 'flex', justifyContent: 'center' }} className="smallBox">

            <Box>
              <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h4'>Login</Typography>
              <hr />
              <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h7'>Sign in to your account</Typography>
              <Box
                component="form"
                onSubmit={Check} // Add onSubmit event handler
                sx={{
                  '& > :not(style)': { m: 1, width: '45ch', display: 'flex', justifyContent: 'center' },
                }}
                noValidate
                autoComplete="off"
              >
                <TextField id="outlined-basic" label="Email" variant="outlined" value={email} onChange={(event) => setEmail(event.target.value)} />
                <TextField id="outlined-basic" type="password" label="Password" variant="outlined" value={password} onChange={(event) => setPassword(event.target.value)} />
                <Stack spacing={2} direction="row">
                  <Button type="submit" variant="contained" sx={{ width: 180, height: 45 }}>Login</Button>
                </Stack>


              </Box>
            </Box>
          </Box>

        </Paper>

      </Box>
      <div className='icon-container'>
        <a href="nuParent.apk" download>
          <svg xmlns="http://www.w3.org/2000/svg" className='icon-play' enable-background="new 0 0 24 24" viewBox="0 0 24 24" id="google-play"><path fill="#ffc107" d="m23 12c0 .75-.42 1.41-1.03 1.75l-5.2 2.89-4.4-4.64 4.4-4.64 5.2 2.89c.61.34 1.03 1 1.03 1.75z"></path><path fill="#03a9f4" d="m12.37 12-10.8 11.39c-.36-.36-.57-.85-.57-1.39v-20c0-.54.21-1.03.57-1.39z"></path><path fill="#f44336" d="m12.37 12 4.4 4.64-12.8 7.11c-.29.16-.62.25-.97.25-.56 0-1.07-.23-1.43-.61z"></path><path fill="#4caf50" d="m16.77 7.36-4.4 4.64-10.8-11.39c.36-.38.87-.61 1.43-.61.35 0 .68.09.97.25z"></path></svg>
        </a>
      </div>
    </>
  );
};

export default Login;
