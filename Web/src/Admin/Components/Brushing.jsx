import React, { Fragment, useLayoutEffect, useState } from 'react'
import { DataGrid } from '@mui/x-data-grid'
import {
   Box,
   Button,
   FormControl,
   InputLabel,
   MenuItem,
   Select,
   Stack,
   TextField,
   Typography,
   Dialog,
   DialogActions,
   DialogContent,
   DialogContentText,
   DialogTitle,
} from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import { db } from '../../config/firebase'
import { addDoc, collection, getDocs, deleteDoc, doc, updateDoc } from 'firebase/firestore'
import FullPageLoader from './FullPageLoader'
import EditNoteIcon from '@mui/icons-material/EditNote'


const Brushing = () => {
   const [open, setOpen] = useState(false)
   const [brushingData, setBrushingData] = useState([])
   const [brushing, setBrushing] = useState('')
   const [selectedRow, setSelectedRow] = useState(null)
   const [ageData, setAgeData] = useState([])
   const [age, setAge] = useState('')
   const [error, setError] = useState('')
   const [checkLoad, setCheckBlur] = useState(false)
   const [selectedDoc, setSelectedDoc] = useState(null)

   const handleClickOpen = (params) => {
      setSelectedRow(params)
      setOpen(true)
   }

   const handleClose = () => {
      setOpen(false)
   }

   const addBrushing = async (e) => {
      e.preventDefault() // prevent form submission
      setCheckBlur(true)
      if (!brushing || !age) {
         setError('Both Brushing Details and Age are required')
         setCheckBlur(false)
         return
      }

      try {

        if(selectedDoc){
           const brushingRef = doc(db, 'brushing', selectedDoc)

            await updateDoc(brushingRef, {
              brushing, age
            })

        }else{
          await addDoc(collection(db, 'brushing'), { brushing, age })

        }
        setSelectedDoc(null)
         loadBrushing()
         setBrushing('')
         setAge('')
         setError('')
      } catch (error) {
         console.error('Error adding document: ', error)
      }
   }

   const loadBrushing = async () => {
      try {

         const brushingQuerySnapshot = await getDocs(collection(db, 'brushing'))
         const brushingData = brushingQuerySnapshot.docs.map((doc, index) => ({
            id: doc.id,
            index: index + 1,
            ...doc.data(),
         }))

         const ageGroupsQuerySnapshot = await getDocs(
            collection(db, 'ageGroups')
         )
         const ageGroupsData = ageGroupsQuerySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
         }))

         const joinedData = brushingData
            .filter((brushingItem) =>
               ageGroupsData.some(
                  (ageGroup) => ageGroup.id === brushingItem.age
               )
            )
            .map((brushingItem) => {
               const matchingAgeGroup = ageGroupsData.find(
                  (ageGroup) => ageGroup.id === brushingItem.age
               )
               return { ...brushingItem, ageGroup: matchingAgeGroup.age }
            })

         setBrushingData(joinedData)
         setCheckBlur(false)
      } catch (error) {
         console.error('Error getting documents: ', error)
      }
   }

   const deleteBrushing = async () => {
      try {
         if (selectedRow) {
            setCheckBlur(true)
            await deleteDoc(doc(db, 'brushing', selectedRow.id))
            setOpen(false)
            setSelectedRow(null)
            loadBrushing()
         }
      } catch (error) {
         console.error('Error removing document: ', error)
      }
   }

   const loadAgeGroups = async () => {
      try {
         const querySnapshot = await getDocs(collection(db, 'ageGroups'))
         const ageGroups = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
         }))
         setAgeData(ageGroups)
      } catch (error) {
         console.error('Error getting documents: ', error)
      }
   }

   const handleClickGetOneDoc = async (selectedDoc) => {
    try {
      console.log(selectedDoc);
       const { row } = selectedDoc
       setAge(row.age)
       setBrushing(row.brushing)
       setSelectedDoc(row.id)
    } catch (error) {
       console.log(error)
    }
 }


  

   useLayoutEffect(() => {
      loadBrushing()
      loadAgeGroups()
            setCheckBlur(true)
   },[])


   const columns = [
      { field: 'index', headerName: 'ID', flex: 1 },
      { field: 'brushing', headerName: 'Brushing ', flex: 3 },
      { field: 'ageGroup', headerName: 'Age ', flex: 3 },
      {
         field: 'action',
         headerName: 'Action',
         flex: 1,
         renderCell: (params) => (
            <Fragment>
               <DeleteIcon
                  className='divListDelete'
                  onClick={() => handleClickOpen(params)}
                  sx={{ mx: 1 }}
               />
               <EditNoteIcon
                  sx={{ mx: 1 }}
                  onClick={() => handleClickGetOneDoc(params)}
               />
            </Fragment>
         ),
      },
   ]

   return (
      <>
         {checkLoad ? (
            <FullPageLoader />
         ) : (
            <Box>
               <div>
                  <Typography
                     variant='h4'
                     gutterBottom
                  >
                     Brushing
                  </Typography>
                  <form onSubmit={addBrushing}>
                     <Box
                        sx={{
                           '& > :not(style)': { m: 4, width: '100%' },
                        }}
                        noValidate
                        autoComplete='off'
                     >
                        <Stack
                           spacing={2}
                           direction='row'
                           sx={{ p: 2 }}
                        >
                           <FormControl sx={{ minWidth: 120 }}>
                              <InputLabel id='demo-simple-select-label'>
                                 Age
                              </InputLabel>
                              <Select
                                 labelId='demo-simple-select-label'
                                 id='demo-simple-select'
                                 value={age}
                                 label='Age'
                                 onChange={(event) => {
                                    setAge(event.target.value)
                                    setError('')
                                 }}
                              >
                                 {ageData.map((doc, key) => (
                                    <MenuItem
                                       key={key}
                                       value={doc.id}
                                    >
                                       {doc.age}
                                    </MenuItem>
                                 ))}
                              </Select>
                           </FormControl>
                           <TextField
                              id='outlined-basic'
                              onChange={(event) => {
                                 setBrushing(event.target.value)
                                 setError('')
                              }}
                              multiline
                              maxRows={3}
                              sx={{ width: '60%', minWidth: 200 }}
                              label='Brushing Details'
                              variant='outlined'
                              autoComplete='off'
                              value={brushing}
                           />
                           <Button
                              variant='contained'
                              sx={{ width: 150, maxHeight: 50 }}
                              type='submit'
                           >
                              Submit
                           </Button>
                        </Stack>
                        {error && (
                           <Typography color='error'>{error}</Typography>
                        )}
                     </Box>
                  </form>
                  <div style={{ height: 400, width: '100%' }}>
                     <DataGrid
                        rows={brushingData}
                        columns={columns}
                        initialState={{
                           pagination: {
                              paginationModel: { page: 0, pageSize: 5 },
                           },
                        }}
                        pageSizeOptions={[5, 10]}
                     />
                  </div>
               </div>
               <Dialog
                  open={open}
                  onClose={handleClose}
                  aria-labelledby='alert-dialog-title'
                  aria-describedby='alert-dialog-description'
               >
                  <DialogTitle id='alert-dialog-title'>
                     {'Confirm Delete'}
                  </DialogTitle>
                  <DialogContent>
                     <DialogContentText id='alert-dialog-description'>
                        Are you sure to delete this user permanently
                     </DialogContentText>
                  </DialogContent>
                  <DialogActions>
                     <Button onClick={handleClose}>Disagree</Button>
                     <Button
                        onClick={deleteBrushing}
                        autoFocus
                     >
                        Agree
                     </Button>
                  </DialogActions>
               </Dialog>
            </Box>
         )}
      </>
   )
}

export default Brushing
