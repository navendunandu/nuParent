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
    <Box className="BoxContainer">
      <Paper elevation={0} className="PaperContainer">
        <Box sx={{ width: '500px', m: 2, display: 'flex', justifyContent: 'center' }}  className="smallBox">
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
              <TextField id="outlined-basic" label="Email" variant="outlined" value={email} onChange={(event) => setEmail(event.target.value)}  />
              <TextField id="outlined-basic" type="password" label="Password" variant="outlined" value={password} onChange={(event) => setPassword(event.target.value)} />
              <Stack spacing={2} direction="row">
                <Button type="submit" variant="contained" sx={{ width: 180, height: 45 }}>Login</Button>
              </Stack>
             
            </Box>
          </Box>
        </Box>
      </Paper>
    </Box>
  );
};

export default Login;
