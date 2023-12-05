import { Layout, Row, Col, Button, Spin, List, Checkbox, Input} from "antd";
import type {CheckboxChangeEvent} from "antd/es/checkbox"
import { Provider, Network } from "aptos";
import { useWallet } from "@aptos-labs/wallet-adapter-react";
import { useState, useEffect } from "react";

import "@aptos-labs/wallet-adapter-ant-design/dist/index.css";

import Navbar from "./components/Navbar/Navbar";

export const provider = new Provider(Network.DEVNET);
export const moduleAddress = "0xf47fe7581a575205d4b6b08d95e84b96725fdb93dfb112691660c9a133eeb312";
export const moduleName = "TradingPlatform";

function App() {
	const { account } = useWallet();
	const wallet = (window as any).aptos;
	const [userRegistered, setUserRegistered] = useState<boolean>(false);
	const [transactionInProgress, setTransactionInProgress] = useState<boolean>(false);
	const [price, setPrice] = useState<number>(0);
	const [units, setUnits] = useState<number>(0);
	console.log(account);
	// const onWriteTask = (event: React.ChangeEvent<HTMLInputElement>) => {
	// 	const value = event.target.value;
	// 	setNewTask(value);
	// }

	// const onCheckBoxChange = async (event: CheckboxChangeEvent, task_id: string) => {
	// 	if(!account) return;
	// 	if(!event.target.checked) return;
	// 	setTransactionInProgress(true);

	// 	const payload = {
	// 		function: `${moduleAddress}::todolist::complete_task`,
	// 		arguments: [task_id],
	// 		type: 'entry_function_type',
	// 		type_arguments: [],
	// 	};

	// 	try {
	// 		const response = await wallet.signAndSubmitTransaction(payload);
	// 		await provider.waitForTransaction(response.hash);
	// 		setTasks((prevState) => {
	// 			const newState = prevState.map((obj) => {
	// 				if(obj.task_id === task_id) {
	// 					return {...obj,	completed: true};
	// 				}
	// 				return obj;
	// 			})

	// 			return newState;
	// 		})
	// 	} catch (error: any) {
	// 		console.log("error", error);
	// 	} finally {
	// 		setTransactionInProgress(false);
	// 	}
	// }

	// const onTaskAdded = async () => {
	// 	if(!account) return;
	// 	setTransactionInProgress(true);

	// 	const payload = {
	// 		type: "entry_function_payload",
	// 		function: `${moduleAddress}::todolist::create_task`,
	// 		type_arguments: [],
	// 		arguments: [newTask],
	// 	};

	// 	const latestId = tasks.length > 0 ? parseInt(tasks[tasks.length-1].task_id) + 1: 1;

	// 	const newTaskToPush = {
	// 		address: account.address,
	// 		completed: false,
	// 		content: newTask,
	// 		task_id: latestId + "",
	// 	};

	// 	try {
	// 		const response = await wallet.signAndSubmitTransaction(payload);
	// 		await provider.waitForTransaction(response.hash);
	// 		let newTasks = [...tasks];
	// 		newTasks.push(newTaskToPush);
	// 		setTasks(newTasks);
	// 		setNewTask("");
	// 	} catch (error: any) {
	// 		console.log("error", error);
	// 	} finally {
	// 		setTransactionInProgress(false);
	// 	}
	// }

	const fetchUserInfo = async () => {
		if (!account) return [];
		try {
			const UserResource = await provider.getAccountResource(
				account.address,
				`${moduleAddress}::${moduleName}::UserResource`
			);
			console.log(UserResource)
			setUserRegistered(true);
		} catch (e: any) {
			console.log("[fetchUserInfo]: ", e)
			setUserRegistered(false);
		}
	};

	const register = async () => {
		if (!account) return [];
		setTransactionInProgress(true);
		// build a transaction payload to be submited
		const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::register`,
			type_arguments: [],
			arguments: [],
		};
		try {
			const response = await wallet.signAndSubmitTransaction(payload);
			await provider.waitForTransaction(response.hash);
			setUserRegistered(true);
		} catch (error: any) {
			console.log(error)
			setUserRegistered(false);
		} finally {
			setTransactionInProgress(false)
		}
	};

	useEffect(() => {
		fetchUserInfo();
	}, [account?.address]);


	const handleSellRequest = async () => {
		if (!account) return [];
		setTransactionInProgress(true);
		// build a transaction payload to be submited
		const payload = {
			type: "entry_function_payload",
			function: `${moduleAddress}::${moduleName}::sell_request`,
			type_arguments: [],
			arguments: [price,units],
		};
		console.log(typeof price, typeof units);
		try {
			const response = await wallet.signAndSubmitTransaction(payload);
			// console.log(response)
			await provider.waitForTransaction(response.hash);
			setUserRegistered(true);
		} catch (error: any) {
			console.log(error)
			setUserRegistered(false);
		} finally {
			setTransactionInProgress(false)
		}
	};
	return (
		<>
			<Navbar/>
			<Spin spinning={transactionInProgress}>
				{!userRegistered ? (
					<Row gutter={[0, 32]} style={{ marginTop: "2rem" }}>
						<Col span={8} offset={8}>
							<Button onClick={register} block type="primary" style={{ height: "40px", backgroundColor: "#3f67ff" }}>
								Register
							</Button>
						</Col>
					</Row>
				) : (
					<h1>
						
						<form>
        <label>
          Price:
          <input
            type="number"
            value={price}
            onChange={(e) => setPrice(parseInt(e.target.value))}
          />
        </label>
        <br />
        <label>
          Units:
          <input
            type="number"
            value={units}
            onChange={(e) => setUnits(parseInt(e.target.value))}
          />
        </label>
        <br />
        <button type="button" onClick={handleSellRequest}>
          Submit
        </button>
      </form>
					</h1>
					// <Row gutter={[0,32]} style={{ marginTop: "2rem" }}>
					// 	<Col span={8} offset={8}>
					// 		<Input.Group compact>
					// 			<Input
					// 			onChange={onWriteTask}
					// 			style={{ width: "calc(100% - 60px)" }}
					// 			placeholder="Add a Task"
					// 			size="large"
					// 			value={newTask}
					// 			/>
					// 			<Button
					// 			type="primary"
					// 			style={{ height: "40px", backgroundColor: "#3f67ff" }}
					// 			onClick={onTaskAdded}
					// 			>
					// 			Add
					// 			</Button>
					// 		</Input.Group>
					// 	</Col>
					// 	<Col span={8} offset={8}>
					// 	{tasks && (
					// 		<List
					// 			size="small"
					// 			bordered
					// 			dataSource={tasks}
					// 			renderItem={(task: any) => (
					// 			<List.Item actions={[
					// 				<div>
					// 					{task.completed ? (
					// 						<Checkbox defaultChecked={true} disabled />
					// 					) : (
					// 						<Checkbox onChange={(event) => {onCheckBoxChange(event, task.task_id)}} />
					// 					)}
					// 				</div>
					// 			]}>
					// 				<List.Item.Meta
					// 				title={task.content}
					// 				description={
					// 					<a
					// 					href={`https://explorer.aptoslabs.com/account/${task.address}/`}
					// 					// target="_blank"
					// 					>{`${task.address.slice(0, 6)}...${task.address.slice(-5)}`}</a>
					// 				}
					// 				/>
					// 			</List.Item>
					// 			)}
					// 		/>
					// 		)}
					// 	</Col>
					// </Row>
				)}
			</Spin>
		</>
	);
}

export default App;