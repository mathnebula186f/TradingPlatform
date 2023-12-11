import {
    IconButton,
    Icon,
    Drawer,
    DrawerBody,
    DrawerHeader,
    DrawerOverlay,
    DrawerContent,
    DrawerCloseButton,
    useDisclosure
} from '@chakra-ui/react' 
import { FiMenu } from 'react-icons/fi';

const Sidebar = () =>{
    const { isOpen, onOpen, onClose } = useDisclosure();
  
    return (
    <>
        <IconButton margin='5px' fontSize='40px' aria-label="Open Sidebar" icon={<Icon as={FiMenu} />} onClick={onOpen} variant="ghost" />
        <Drawer placement={'left'} onClose={onClose} isOpen={isOpen}>
        <DrawerOverlay />
            <DrawerContent>
            <DrawerCloseButton />
            <DrawerHeader borderBottomWidth='1px'>Basic Drawer</DrawerHeader>
            <DrawerBody>
                <p>Some contents...</p>
                <p>Some contents...</p>
                <p>Some contents...</p>
            </DrawerBody>
            </DrawerContent>
        </Drawer>
    </>
      
  )
}

export default Sidebar;