import React, { Fragment, useLayoutEffect, useState } from 'react'
// import { DataGrid } from '@mui/x-data-grid'
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
   IconButton,
   TableContainer,
   Table,
   TableHead,
   TableRow,
   TableCell,
   Paper,
   TableBody,
} from '@mui/material'
import DeleteIcon from '@mui/icons-material/Delete'
import AddIcon from '@mui/icons-material/Add'
import { db } from '../../config/firebase'
import {
   addDoc,
   collection,
   getDocs,
   deleteDoc,
   doc,
   updateDoc,
   //    updateDoc,
} from 'firebase/firestore'
import FullPageLoader from './FullPageLoader'
import EditNoteIcon from '@mui/icons-material/EditNote'
// import { selectedIdsLookupSelector } from '@mui/x-data-grid'

const Brushing = () => {
   const [open, setOpen] = useState(false)
   const [brushingData, setBrushingData] = useState([])
   const [brushingTitle, setBrushingTitle] = useState('')
   const [selectedRow, setSelectedRow] = useState(null)
   const [brushGroupData, setBrushGroupData] = useState([])
   const [brushGroup, setBrushGroup] = useState('')
   const [brushContent, setBrushContent] = useState(['']) // State to hold array of brush content
   const [error, setError] = useState('')
   const [checkLoad, setCheckBlur] = useState(false)
   const [brushingOrder, setBrushingOrder] = useState(0)
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
      if (!selectedDoc) {
         if (
            !brushingTitle ||
            !brushGroup ||
            brushContent.some((content) => !content)
         ) {
            setError('Both Brushing Details and Age are required')
            setCheckBlur(false)
            return
         }
      }

      try {
         if (selectedDoc) {
            // const brushingQuerySnapshot = await getDocs(
            //    collection(db, 'brushingDetails')
            // )
            // const brushingData = brushingQuerySnapshot.docs.map(
            //    (doc) => ({
            //       id: doc.id,
            //       ...doc.data(),
            //    })
            // )
            // const orderExists = brushingData.some(item => item.brushGroup === selectedDoc && item.brushingOrder === brushingOrder);
            // console.log(orderExists);



            // if (orderExists) {
            //    // Show alert if the order already exists for the selected group
            //    alert(
            //       `The order ${brushingOrder} already exists for the selected group.`
            //    )
            //    setCheckBlur(false)
            //    return
            // }

            const brushingRef = doc(db, 'brushingDetails', selectedDoc)

            await updateDoc(brushingRef, {
               brushingOrder,
            })
         } else {
            await addDoc(collection(db, 'brushingDetails'), {
               brushingTitle,
               brushGroup,
               brushContent,
               brushingOrder:parseInt(brushingOrder),
            })
         }
         setSelectedDoc(null)
         loadBrushing()
         setBrushingTitle('')
         setBrushGroup('')
         setBrushContent(['']) // Reset brush content array
         setError('')
      } catch (error) {
         console.error('Error adding document: ', error)
      }
   }

   const loadBrushing = async () => {
      try {
         const brushingQuerySnapshot = await getDocs(
            collection(db, 'brushingDetails')
         )
         const brushingData = brushingQuerySnapshot.docs.map((doc, index) => ({
            id: doc.id,
            index: index + 1,
            ...doc.data(),
         }))

         const brishingGroupsQuerySnapshot = await getDocs(
            collection(db, 'brushingGroups')
         )
         const brushingGroupsData = brishingGroupsQuerySnapshot.docs.map(
            (doc) => ({
               id: doc.id,
               ...doc.data(),
            })
         )

         const joinedData = brushingData
            .filter((brushingItem) =>
               brushingGroupsData.some(
                  (brushGroupIng) =>
                     brushGroupIng.id === brushingItem.brushGroup
               )
            )
            .map((brushingItem) => {
               const matchingBrushGroup = brushingGroupsData.find(
                  (brushGrouping) =>
                     brushGrouping.id === brushingItem.brushGroup
               )
               return {
                  ...brushingItem,
                  brushingGroup: matchingBrushGroup.brushing,
               }
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
            await deleteDoc(doc(db, 'brushingDetails', selectedRow.id))
            setOpen(false)
            setSelectedRow(null)
            loadBrushing()
         }
      } catch (error) {
         console.error('Error removing document: ', error)
      }
   }

   const loadbrushGroups = async () => {
      try {
         const querySnapshot = await getDocs(collection(db, 'brushingGroups'))
         const brushingGroups = querySnapshot.docs.map((doc) => ({
            id: doc.id,
            ...doc.data(),
         }))
         setBrushGroupData(brushingGroups)
      } catch (error) {
         console.error('Error getting documents: ', error)
      }
   }

   const handleClickGetOneDoc = async (row) => {
      try {
         setSelectedDoc(row.id)
      } catch (error) {
         console.log(error)
      }
   }

   const handleAddContent = () => {
      setBrushContent((prevContent) => [...prevContent, '']) // Add a new empty content field
   }

   const handleChangeContent = (index, value) => {
      const updatedContent = [...brushContent]
      updatedContent[index] = value
      setBrushContent(updatedContent)
   }

   useLayoutEffect(() => {
      loadBrushing()
      loadbrushGroups()
      setCheckBlur(true)
   }, [])

   //    const columns = [
   //       { field: 'index', headerName: 'ID', flex: 1 },
   //       { field: 'brushGroup', headerName: 'Brush Group ', flex: 3 },
   //       { field: 'brushingTitle', headerName: 'Brushing Title ', flex: 3 },
   //       {
   //         field: 'brushContent',
   //         headerName: 'Brush Content',
   //         flex: 3,
   //         renderCell: (params) => (
   //           <div style={{ whiteSpace: 'pre-line' }}>{params.value}</div>
   //         ),
   //         valueGetter: (params) => params.row.brushContent.join('\n'),
   //       },
   //            {
   //          field: 'action',
   //          headerName: 'Action',
   //          flex: 1,
   //          renderCell: (params) => (
   //             <Fragment>
   //                <DeleteIcon
   //                   className='divListDelete'
   //                   onClick={() => handleClickOpen(params)}
   //                   sx={{ mx: 1 }}
   //                />
   //                {/* <EditNoteIcon
   //                   sx={{ mx: 1 }}
   //                   onClick={() => handleClickGetOneDoc(params)}
   //                /> */}
   //             </Fragment>
   //          ),
   //       },
   //    ]

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
                     Brushing Details
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
                           sx={{ px: 4 }}
                        >
                           {!selectedDoc && (
                              <>
                                 {' '}
                                 <FormControl sx={{ minWidth: 160 }}>
                                    <InputLabel id='demo-simple-select-label'>
                                       Brushing Group
                                    </InputLabel>
                                    <Select
                                       labelId='demo-simple-select-label'
                                       id='demo-simple-select'
                                       value={brushGroup}
                                       label='Brushing Group'
                                       onChange={(event) => {
                                          setBrushGroup(event.target.value)
                                          setError('')
                                       }}
                                    >
                                       {brushGroupData.map((doc, key) => (
                                          <MenuItem
                                             key={key}
                                             value={doc.id}
                                          >
                                             {doc.brushing}
                                          </MenuItem>
                                       ))}
                                    </Select>
                                 </FormControl>
                                 <TextField
                                    id='outlined-basic'
                                    onChange={(event) => {
                                       setBrushingTitle(event.target.value)
                                       setError('')
                                    }}
                                    multiline
                                    maxRows={3}
                                    sx={{ width: '80%', minWidth: 200 }}
                                    label='Brushing Title'
                                    variant='outlined'
                                    autoComplete='off'
                                    value={brushingTitle}
                                 />{' '}
                              </>
                           )}
                           <TextField
                              id='outlined-basic'
                              onChange={(event) => {
                                 setBrushingOrder(event.target.value)
                                 setError('')
                              }}
                              sx={{ width: '80%', minWidth: 200 }}
                              label='Brushing Order'
                              variant='outlined'
                              autoComplete='off'
                              value={brushingOrder}
                           />
                        </Stack>
                        {!selectedDoc && (
                           <Stack
                              direction='row'
                              sx={{
                                 p: 2,
                                 display: 'flex',
                                 alignItems: 'flex-end',
                              }}
                           >
                              <Box
                                 sx={{
                                    display: 'flex',
                                    flexDirection: 'column',
                                    gap: 3,
                                 }}
                              >
                                 {brushContent.map((content, index) => (
                                    <TextField
                                       key={index}
                                       id={`outlined-basic-${index}`}
                                       onChange={(event) =>
                                          handleChangeContent(
                                             index,
                                             event.target.value
                                          )
                                       }
                                       multiline
                                       maxRows={3}
                                       fullWidth
                                       sx={{ width: '90%', minWidth: 900 }}
                                       label={`Brushing Content ${index + 1}`}
                                       variant='outlined'
                                       autoComplete='off'
                                       value={content}
                                    />
                                 ))}
                              </Box>

                              <IconButton
                                 aria-label='delete'
                                 size='large'
                                 onClick={handleAddContent} // Add button to add more content fields
                              >
                                 <AddIcon />
                              </IconButton>
                           </Stack>
                        )}
                        <Stack
                           direction='row'
                           sx={{
                              px: 5,
                              display: 'flex',
                              justifyContent: 'flex-end',
                           }}
                        >
                           <Button
                              variant='contained'
                              sx={{ width: 180, maxHeight: 60 }}
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
                  {/* <div style={{ height: 400, width: '100%' }}>
                     <DataGrid
                        rows={brushingData}
                        columns={columns}
                        autoHeight 
                        initialState={{
                           pagination: {
                              paginationModel: { page: 0, pageSize: 5 },
                           },
                        }}
                        pageSizeOptions={[5, 10]}
                     />
                  </div> */}

                  <div>
                     <TableContainer component={Paper}>
                        <Table
                           sx={{ minWidth: 650 }}
                           aria-label='simple table'
                        >
                           <TableHead>
                              <TableRow>
                                 <TableCell>ID</TableCell>
                                 <TableCell>Brushing Title</TableCell>
                                 <TableCell>Brush Group</TableCell>
                                 <TableCell>Brush Content</TableCell>
                                 <TableCell>Brush Order</TableCell>
                                 <TableCell>Action</TableCell>
                              </TableRow>
                           </TableHead>
                           <TableBody>
                              {brushingData.map((row, index) => (
                                 <TableRow key={index}>
                                    <TableCell>{index+1}</TableCell>
                                    <TableCell>{row.brushingTitle}</TableCell>
                                    <TableCell>{row.brushingGroup}</TableCell>
                                    <TableCell>
                                       {row.brushContent.map(
                                          (item, innerKey) => (
                                             <Box>
                                                {innerKey + 1}, {item}
                                             </Box>
                                          )
                                       )}
                                    </TableCell>
                                    <TableCell>{row.brushingOrder}</TableCell>

                                    <TableCell>
                                       <>
                                          <DeleteIcon
                                             className='divListDelete'
                                             onClick={() =>
                                                handleClickOpen(row)
                                             }
                                             sx={{ mx: 1 }}
                                          />
                                          <EditNoteIcon
                                             sx={{ mx: 1 }}
                                             onClick={() =>
                                                handleClickGetOneDoc(row)
                                             }
                                          />
                                       </>
                                    </TableCell>
                                 </TableRow>
                              ))}
                           </TableBody>
                        </Table>
                     </TableContainer>
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
