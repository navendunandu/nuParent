
import Box from '@mui/material/Box';
import Paper from '@mui/material/Paper';
import './login.css'
import { Button, Stack, TextField, Typography } from '@mui/material';


const Login = () => {
  return (
    <Box
      sx={{
        display: 'flex',
        flexWrap: 'wrap',
        '& > :not(style)': {
          m: 2,
          width: '100%',
          minHeight: 640,
        },
      }}
    >

      <Paper elevation={3} sx={{ display: 'flex', justifyContent: 'center', alignItems: 'center' }}>
        <Box sx={{ width: '50%', height: '40vh', m: 2 }} >
          hello
        </Box>
        <Box sx={{ width: '50%', height: '40vh', m: 2, display: 'flex', justifyContent: 'center' }} >
          <Box>
            <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h4'>Login</Typography>

            <hr />
            <Typography sx={{ display: 'flex', justifyContent: 'center' }} variant='h7'>Signin to your account</Typography>



            <Box
              component="form"
              sx={{
                '& > :not(style)': { m: 1, width: '45ch', display: 'flex', justifyContent: 'center' },
              }}
              noValidate
              autoComplete="off"
            >
              <TextField id="outlined-basic" label="Email" variant="outlined" />
              <TextField id="outlined-basic" label="Password" variant="outlined" />
              <Stack spacing={2} direction="row">
                <Button variant="contained" sx={{ width: 180, height: 45 }}>Login</Button>
              </Stack>

            </Box>
          </Box>
        </Box>
      </Paper>
    </Box>
  )
}

export default Login