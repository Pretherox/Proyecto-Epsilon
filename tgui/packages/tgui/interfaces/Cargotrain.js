import { useBackend } from '../backend';
import {
  Box,
  Button,
  Fragment,
  NoticeBox,
  Section,
  Table
} from '../components';
import { Window } from '../layouts';

export const Cargotrain = (props, context) => {
  const { act, data } = useBackend(context);
  const { crg } = data;
  const load1 = crg && crg.load1;
  const load2 = crg && crg.load2;
  const load3 = crg && crg.load3;
  const load4 = crg && crg.load4;
  const load1name = load1 && load1.name;
  const load2name = load2 && load2.name;
  const load3name = load3 && load3.name;
  const load4name = load4 && load4.name;
  return (
    <Window>
      <Window.Content>
        <Section
          title="Cargo Truck"
          buttons={
			<>
            <Button
			  icon = "sync"
              content="Deattach"
              onClick={() => act('unhook')}
            />
			<Button
			  icon = "eject"
              content="Get out"
              onClick={() => act('go_out')}
            />
			</>
          }
        >
		<Table>
          <Table.Row>
            <Table.Cell bold>Crate 1: </Table.Cell>
              {(!load1 && <NoticeBox>No crate detected</NoticeBox>) || (
				<>
				<Table.Cell bold>{load1.load1name}</Table.Cell>
				<Table.Cell collapsing textAlign="center">
				<Button
					icon="eject"
					content="Eject"
					onClick={() => act('eject1')}
				/>
				</Table.Cell>
				</>
                )}
			</Table.Row>
			<Table.Row>
            <Table.Cell bold>Crate 2:</Table.Cell>
              {(!load2 && <NoticeBox>No crate detected</NoticeBox>) || (
				<>
				<Table.Cell bold>{load2.load2name}</Table.Cell>
				<Table.Cell collapsing textAlign="center">
				<Button
					icon="eject"
					content="Eject"
					onClick={() => act('eject2')}
				/>
				</Table.Cell>
				</>
                )}
			</Table.Row>
			<Table.Row>
            <Table.Cell bold>Crate 3:</Table.Cell>
              {(!load3 && <NoticeBox>No crate detected</NoticeBox>) || (
				<>
				<Table.Cell bold>{load3.load3name}</Table.Cell>
				<Table.Cell collapsing textAlign="center">
				<Button
					icon="eject"
					content="Eject"
					onClick={() => act('eject3')}
				/>
				</Table.Cell>
				</>
                )}
			</Table.Row>
            <Table.Row>
            <Table.Cell bold>Crate 4:</Table.Cell>
              {(!load4 && <NoticeBox>No crate detected</NoticeBox>) || (
				<>
				<Table.Cell bold>{load4.load4name}</Table.Cell>
				<Table.Cell collapsing textAlign="center">
				<Button
					icon="eject"
					content="Eject"
					onClick={() => act('eject4')}
				/>
				</Table.Cell>
				</>
                )}
			</Table.Row>
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
